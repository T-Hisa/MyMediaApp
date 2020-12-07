class UsersController < ApplicationController

  def new
    @user = User.new(flash[:user_params])
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to root_path, flash: { "success": "ようこそ#{user.name}さん" }
    else
      redirect_back fallback_location: root_path, flash: {
        "error": user.errors.full_messages,
        "user_params": user_params
      }
    end
  end

  def login
  end

  private
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
