class UsersController < ApplicationController

  def new
    @user = User.new(flash[:user_params])
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to root_path, flash: { "success": "ログインしました" }
    else
      redirect_to new_user_path, flash: {
        "error": user.errors.full_messages,
        "user_params": user_params
      }
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
