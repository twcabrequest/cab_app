# -*- encoding : utf-8 -*-
require 'will_paginate/array'
require 'yaml'
class CabRequestsController < ApplicationController
  require 'time'

  def index
    if @is_admin
      redirect_to '/support_centers/show'
    else
      redirect_to '/cab_requests/new'
    end
  end

  def new
    session[:requester] ||= fetch_requester_info
    @cab_request = CabRequest.new(requester: session[:cas_user], traveler_name: session[:requester].requester_name, contact_no: session[:requester].requester_contact_no)
  end

  def update
    create
  end

  def create
    @cab_request = CabRequest.new(params[:cab_request])
    @cab_request.requester = session[:cas_user]
    @cab_request.pick_up_date_time = date_time_parser(params[:cab_request][:pick_up_date], params[:cab_request][:pick_up_date_time])
    @other_source = params[:source]
    @other_destination = params[:destination]
    requester = session[:cas_user] + "@thoughtworks.com"
    if @cab_request.source == 'Other'
      @cab_request.source = @other_source
      @source = 'Other'
    end
    if @cab_request.source == 'Airport'
      @cab_request.source = 'Airport - Flight Number : ' + @other_source
      @source = 'Airport'
    end
    if @cab_request.source == 'Guest House'
      @cab_request.source = 'Guest House : ' + @other_source
      @source = 'Guest House'
    end
    if @cab_request.destination == 'Other'
      @cab_request.destination = @other_destination
      @destination = 'Other'
    end
    if @cab_request.destination == 'Airport'
      @cab_request.destination = 'Airport - Flight Number : ' + @other_destination
      @destination = 'Airport'
    end
    if @cab_request.destination == 'Guest House'
      @cab_request.destination = 'Guest House : ' + @other_destination
      @destination = 'Guest House'
    end

    admin_emails = Admin.where(status: true).pluck(:email)
    if admin_emails.include? requester
      requester = ""
    end
    vendor_email = Vendor.where(order: 1).pluck(:email).first
    vendor_id = Vendor.where(order: 1).pluck(:id).first
    host = "http://" + request.host_with_port
    @cab_request.requested_vendor = vendor_id
    if vendor_email == nil
      render template: '_message'

    elsif @cab_request.save
       begin
       CabRequestMailer.send_admin_email(@cab_request,params[:cab_request][:pick_up_date],params[:cab_request][:pick_up_date_time],requester,admin_emails).deliver
       CabRequestMailer.send_vendor_email(@cab_request,params[:cab_request][:pick_up_date],params[:cab_request][:pick_up_date_time],requester,admin_emails,vendor_email,vendor_id,host).deliver
       redirect_to '/cab_requests/show', {:notice => 'Your request has been sent with ReqId ' + @cab_request.id.to_s}
       rescue Exception => e
       @cab_request.errors.add(:some, "error occurred in sending request. Please check your internet connection and book cab again.")
       CabRequest.where(id: @cab_request.id).first.delete
       render template: 'cab_requests/new'
       end
    else
      render template: 'cab_requests/new'
    end
  end

  def show
    @cab_requests = CabRequest.where(requester: session[:cas_user]).reverse
    if @cab_requests
      @cab_requests_page = @cab_requests.paginate(page: params[:page], per_page: 10)
    else
      @cab_requests_page = []
    end
    @dates = []
    @cab_requests.each do |cr|
      @dates.push cr.pick_up_date_time.to_date
    end
    respond_to do |format|
      format.html
      format.xls
    end
  end

  def edit
  end

  private
  def date_time_parser(date, time)
    unless date=="" || time==""
      DateTime.parse(date + ' ' + time + ' +05:30').strftime('%F %T %z')
    end
  end

  def load_config
    config_file = Rails.root.join('base_config.yaml')
    if File.exists? config_file
      base_config = YAML.load_file(config_file)
    else
      base_config = {}
    end

    base_config
  end

  def call_api
    requester_configs = load_config['requester_details'] if load_config
    unless session[:cas_user].nil? || requester_configs.nil?
      requester_details_api = requester_configs['base_api'] + session[:cas_user]
      response = open(requester_details_api, http_basic_authentication: [requester_configs['user_id'], requester_configs['password']]).read rescue nil
    end
    response
  end

  def fetch_requester_info
    @req = Requester.new
    if !true
      response = call_api
      response_json = JSON.parse(response[response.index('{')..response.length]) if response
    else
      response_json = nil
    end
    unless response_json.nil?
      @req.requester_name = response_json['name']
      @req.requester_contact_no = response_json['profile']['mobile']
    end
    @req
  end

end
