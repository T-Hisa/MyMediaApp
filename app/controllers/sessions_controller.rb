class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email])
    if user &.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to mypage_path, flash: { "success": "#{user.name}でログインしました" }
    else
      redirect_back fallback_location: root_path, flash: {
        "error":  ["Eメールまたはパスワードが違います"],
        "email": params[:session][:email]
      }
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, flash: { "info": "ログアウトしました"}
  end

end
