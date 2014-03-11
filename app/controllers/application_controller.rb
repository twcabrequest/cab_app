# -*- encoding : utf-8 -*-

class ApplicationController < ActionController::Base
  include OktaSaml::SessionHelper
  protect_from_forgery
  before_filter :okta_authenticate!
  #before_filter CASClient::Frameworks::Rails::Filter, :except => [:submit_response]
  #include 'okta_saml/session_helper'
  p @current_user
  before_filter :is_admin, :only => [:edit,:index,:new,:show,:create,:update]

  def is_admin
    @is_admin = Admin.pluck(:name).include? `current_user`
  end

  def deroy

  end

end