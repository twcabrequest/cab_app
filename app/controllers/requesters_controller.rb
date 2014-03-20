# -*- encoding : utf-8 -*-
class RequestersController < ApplicationController
  include OktaSaml::SessionHelper

  def logout
    #cookies.delete :auth_token
    #reset_session
    p '+++++++++reached here+++++++++++++'
    session_helper = OktaSaml::SessionHelper.new
    session_helper.sign_out
    #CASClient::Frameworks::Rails::Filter.logout(self)
  end

end
