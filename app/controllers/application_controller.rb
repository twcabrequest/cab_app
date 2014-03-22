# -*- encoding : utf-8 -*-

class ApplicationController < ActionController::Base
  include OktaSaml::SessionHelper
  protect_from_forgery
  before_filter :okta_authenticate!, :except => [:submit_response]
  #before_filter CASClient::Frameworks::Rails::Filter, :except => [:submit_response]
  before_filter :is_admin, :only => [:edit,:index,:new,:show,:create,:update]

  def is_admin
    @is_admin = Admin.pluck(:email).include? @current_user.email
    session[:okta_user] = @current_user.email.partition('@').first
    p session[:requesters_logout_path]+'----'+session[:requesters_logout_url]+'------'+session[:redirect_url]
  end
end