class UsersController < ApplicationController

  def new
    @user = User.new(flash[:user_params])
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to mypage_path, flash: { "success": "ようこそ#{user.name}さん" }
    else
      redirect_back fallback_location: root_path, flash: {
        "error": user.errors.full_messages,
        "user_params": user_params
      }
    end
  end

  def login
  end

  def mypage
  end

  def edit
    @current_user.attributes = flash[:user_update_name_params] if flash[:user_update_name_params]
  end
  
  def update
    if @current_user.update(user_update_name_params)
      redirect_to mypage_path, flash: { "success": "ユーザー情報を更新しました" }
    else
      redirect_back fallback_location: root_path, flash: {
        "error": @current_user.errors.full_messages,
        "user_update_name_params": user_update_name_params
      }
    end
  end

  def password_update
    if @current_user &.authenticate(params[:user][:current_password])
      if params[:user][:password].empty?
        redirect_back fallback_location: root_path, flash: {
          "error": ["新規パスワード欄に記入してください"],
          "user_update_name_params": user_update_name_params,
          "current_password": user_update_password_included_params[:current_password]
        } and return
      end
      if user.update(user_update_params)
        redirect_to mypage_path, flash: { "success": "ユーザー情報を更新しました。パスワードが変更されたことにご注意ください" }
      else
        redirect_back fallback_location: root_path, flash: {
          "error": user.errors.full_messages,
          "user_update_name_params": user_update_name_params,
          "current_password": user_update_password_included_params[:current_password]
        }
      end
    else
      redirect_back fallback_location: root_path, flash: {
        "error": ["現在のパスワードが間違っています。"],
        "user_update_name_params": user_update_name_params
      }
    end
  end
      

  private
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end

    def user_update_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end


    def user_update_name_params
      params.require(:user).permit(:name)
    end

    def user_update_password_included_params
      params.require(:user).permit(:name, :current_password, :password, :password_confirmation)
    end
end
