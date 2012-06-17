class AuthenticationsController < ApplicationController

  def create
    # render request.env['omniauth.auth'].to_yaml

    auth_response = request.env['omniauth.auth']
    user = User.find_by_uid(auth_response['uid'])

    if user
      user.update_access_token(auth_response)
      sign_in(:user, user)
    else
      user = User.create(uid: auth_response['uid'])
      user.save_auth(auth_response)
      if user.save
        flash[:notice] = 'Signin Successful'
      else
        flash[:notice] = 'Signin Failed'
      end
    end

    redirect_to root_path
  end
end
