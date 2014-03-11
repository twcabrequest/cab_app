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
    require 'pry'; binding.pry
    p ">>>>>>>>>>>>>", @current_user.try(:email)
  end

  def self.deroy
    require 'pry';binding.pry
  end

end