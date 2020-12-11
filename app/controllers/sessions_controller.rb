class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email])
    if user &.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to mypage_path, flash: { "success": t('shared.login-success', name: user.name) }
    else
      redirect_back fallback_location: root_path, flash: {
        "error": t('shared.login-error'),
        "email": params[:session][:email]
      }
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, flash: { "info": t('shared.logout-info') }
  end

end
