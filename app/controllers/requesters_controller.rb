# -*- encoding : utf-8 -*-
require 'okta_saml/session_helper'
class RequestersController < ApplicationController
  include OktaSaml::SessionHelper

  def logout
    sign_out
    redirect_to 'https://thoughtworks.oktapreview.com/login/signout'
  end

end
