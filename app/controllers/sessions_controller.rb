class SessionsController < ApplicationController
  include CookieCreateHelper

  def create
    if @current_user
      redirect_back fallback_location: root_path, flash: {
        info: t('shared.already-login')
      }
    else
      user = User.find_by(email: params[:session][:email])
      if user&.authenticate(params[:session][:password])
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        session[:user_id] = user.id
        redirect_to mypage_path, flash: { "success": t('shared.login-success', name: user.name) }
      else
        redirect_back fallback_location: root_path, flash: {
          "error": [t('shared.login-error')],
          "email": params[:session][:email]
        }
      end
    end
  end

  def destroy
    forget(@current_user) if @current_user
    session.delete(:user_id)
    redirect_to root_path, flash: { "info": t('shared.logout-info') }
  end
end
