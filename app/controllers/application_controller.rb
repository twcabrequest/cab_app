# -*- encoding : utf-8 -*-

class ApplicationController < ActionController::Base
  include OktaSaml::SessionHelper
  protect_from_forgery
  before_filter :okta_authenticate!
  #before_filter CASClient::Frameworks::Rails::Filter, :except => [:submit_response]
  #include 'okta_saml/session_helper'
  before_filter :is_admin, :only => [:edit,:index,:new,:show,:create,:update]

  def is_admin
    @is_admin = Admin.pluck(:name).include? `current_user`
    p ">>>>>>>>>>>>>", @current_user.methods.join(",")
    begin
    #p ">>>>>>>>>>>>>>>" , @current_user.firstName
    rescue => ex
      p ">>>>>>>>>ERROR", puts ex.message
    end
  end

  def self.deroy
    require 'pry';binding.pry
  end

end