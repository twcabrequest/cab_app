# -*- encoding : utf-8 -*-
require 'okta_saml/session_helper'
class RequestersController < ApplicationController
  include OktaSaml::SessionHelper

  def logout
    sign_out
    redirect_to 'http://tranquil-basin-1474.herokuapp.com/'
  end

end
