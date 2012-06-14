class AuthenticationsController < ApplicationController

  def create
    omniauth = request.env['omniauth.auth']
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])

    if authentication
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create(provider: omniauth['provider'], uid: omniauth['uid'])
      flash[:notice] = 'Authentication Successful'
      redirect_to celebrity_url
    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = 'Authentication Successful'
        sign_in_and_redirect(:user, authentication.user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end
end
