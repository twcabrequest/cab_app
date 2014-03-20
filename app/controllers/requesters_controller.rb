# -*- encoding : utf-8 -*-
class RequestersController < ApplicationController
  include OktaSaml::SessionHelper

  def logout
    #cookies.delete :auth_token
    #reset_session
    p '+++++++++reached here+++++++++++++'
    @current_user.sign_out
    #:sign_out
    #CASClient::Frameworks::Rails::Filter.logout(self)
  end

end
