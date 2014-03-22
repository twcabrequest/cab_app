# -*- encoding : utf-8 -*-
require 'okta_saml/session_helper'
class RequestersController < ApplicationController
  include OktaSaml::SessionHelper

  def logout
    sign_out
    session[:redirect_url] = nil
    redirect_to 'https://thoughtworks.oktapreview.com/login/signout'
  end

end
