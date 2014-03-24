# -*- encoding : utf-8 -*-
require 'okta_saml/session_helper'
class RequestersController < ApplicationController
  include OktaSaml::SessionHelper

  def logout
    sign_out
    redirect_to "http://" + request.host_with_port
  end

end
