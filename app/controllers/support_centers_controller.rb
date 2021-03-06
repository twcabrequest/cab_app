# -*- encoding : utf-8 -*-
require 'will_paginate/array'
class SupportCentersController < ApplicationController

  def index
    @admins_name_arr = Admin.where(status: true).pluck(:name)
    @admins_contact_no_arr = Admin.where(status: true).pluck(:contact_no)
    @admins_email_arr = Admin.where(status: true).pluck(:email)
    @admins_name = ""
    @admins_contact_no = ""
    @admins_email = ""
    @admins_name_arr.each do |admin_name|
      @admins_name = @admins_name + admin_name + " , "
    end
    @admins_contact_no_arr.each do |admin_contact|
      @admins_contact_no = @admins_contact_no + admin_contact + " , "
    end
    @admins_email_arr.each do |admin_email|
      @admins_email = @admins_email + admin_email + " , "
    end
    @admins_name = @admins_name[0..@admins_name.length - 3]
    @admins_contact_no = @admins_contact_no[0..@admins_contact_no.length - 3]
    @admins_email = @admins_email[0..@admins_email.length - 3]
    @vendor = Vendor.where(order: 1).first
    @admins = Admin.all
    @all_active = true
    @admins.each do |admin|
      @all_active = @all_active && admin.status
    end
  end

  def update
    if params[:admin] == "All"
      @admins = Admin.all
      @admins.each do |admin|
        admin.update_attribute(:status, 'true')
      end
    else
      admin = Admin.where(name: params[:admin]).first
      update_status(admin)
    end
    redirect_to support_centers_path
  end

  def update_cab_request_status
    if !params[:id]
      redirect_to '/support_centers/show'
    else
      @cab_request = CabRequest.where(id: params[:id]).first
      @cab_request1 = CabRequest.where(id: params[:id]).first
      @cab_request1.status = params[:new_status]
      @cab_requests = CabRequest.all.reverse
      requester = CabRequest.where(id: params[:id]).pluck(:requester).first + "@thoughtworks.com"
      date = @cab_request.pick_up_date_time.to_date.strftime("%d/%m/%Y")
      time = ist(@cab_request.pick_up_date_time)
      begin
        CabRequestMailer.send_admin_email(@cab_request1, date, time, requester, "").deliver
        @cab_request.update_attribute(:status, params[:new_status])
        redirect_to '/support_centers/show'
      rescue Exception => e
        @cab_requests.first.errors.add(:some, "error occurred in updating status. Please check your internet connection and update status again.")
        @is_admin = true
        if @cab_requests
          @cab_requests_page = @cab_requests.paginate(page: params[:page], per_page: 10)
        else
          @cab_requests_page = []
        end
        @dates = []
        @cab_requests.each do |cab_request|
          @dates.push cab_request.pick_up_date_time.to_date
        end
        render template: 'support_centers/show'
      end
    end
  end

  def show
    if params[:from]
      from_date = Time.parse(date_time_parser(params[:from], '00:00:00'))
      to_date = Time.parse(date_time_parser(params[:to], '00:00:00')).tomorrow()
    end
    if (params[:filter_by] == "Booking Date")
      @cab_requests = CabRequest.where(created_at: (from_date..to_date)).order(:created_at)
    elsif (params[:filter_by] == "Travel Date")
      @cab_requests = CabRequest.where(pick_up_date_time: (from_date..to_date)).order(:pick_up_date_time)
    else
      @cab_requests ||= CabRequest.all.reverse
    end
    if @cab_requests
      @cab_requests_page = @cab_requests.paginate(page: params[:page], per_page: 10)
    else
      @cab_requests_page = []
    end
    @dates = []
    @cab_requests.each do |cab_request|
      @dates.push cab_request.pick_up_date_time.to_date
    end
    @filter_by = params[:filter_by]
    @from = params[:from]
    @to = params[:to]
    respond_to do |format|
      format.html
      format.xls
    end

  end

  private
  def update_status(active_support_person)
    active_support_person_class = active_support_person.class
    support_persons = active_support_person_class.all
    support_persons.each do |support_person|
      if (support_person.name == active_support_person.name)
        support_person.update_attribute(:status, 'true')
      else
        support_person.update_attribute(:status, 'false')
      end
    end
  end

  def date_time_parser(date, time)
    unless date=="" || time==""
      DateTime.parse(date + ' ' + time + ' +05:30').strftime('%F %T %z')
    end
  end

  def ist(time)
    unless time.nil?
      time.in_time_zone(TZInfo::Timezone.get('Asia/Kolkata')).strftime('%I:%M %p')
    end
  end
end
