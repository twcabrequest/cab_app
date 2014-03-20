# -*- encoding : utf-8 -*-
class RequestersController < ApplicationController
  include OktaSaml::SessionHelper

  def logout
    cookies.delete :auth_token
    reset_session
    :sign_out
    #CASClient::Frameworks::Rails::Filter.logout(self)
  end

end
