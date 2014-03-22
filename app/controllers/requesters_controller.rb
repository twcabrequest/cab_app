# -*- encoding : utf-8 -*-
require 'okta_saml/session_helper'
class RequestersController < ApplicationController
  include OktaSaml::SessionHelper

  def logout
    #cookies.delete :auth_token
    #reset_session
    p '+++++++++reached here+++++++++++++'
    #@current_user.methods
    sign_out
    redirect_to 'https://thoughtworks.oktapreview.com/login/signout'
    #cookies.delete(:remember_token)
    #@current_user = nil
    #CASClient::Frameworks::Rails::Filter.logout(self)
  end

end
