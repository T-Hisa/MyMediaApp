class UsersController < ApplicationController
  include ApplicationControllerHelper
  before_action :logged_in?, only: %i[ mypage edit update password_update ]
  def new
    @user = User.new(flash[:user_params])
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to mypage_path, flash: { "success": t('shared.welcome', name: user.name) }
    else
      # UsersControllerHelper で定義してあるメソッド
      cause_some_error(user.errors.full_messages)
      redirect_with_error("user_params": user_params)
    end
  end

  def login
  end

  def mypage
    @pagy, @articles = pagy(@current_user.articles)
    @pagy_2, @favorite_articles = pagy(@current_user.favorite_articles) if @current_user.favorite_articles
  end

  def edit
    @current_user.attributes = flash[:name] if flash[:name]
  end
  
  def update
    flag = true
    # update_attribute で更新しようとすると、validationチェックが行われないので、
    # 名前欄が空白・長すぎる場合は、モデルのバリデーションと同等のエラーメッセージを手動で表示するようにする
    if user_update_name_params[:name].empty?
      flag = false
      error_message = t('shared.name_blank')
    else user_update_name_params[:name].size >  16
      flag = false
      error_message = t('shared.name_too_long')
    end
    # バリデーションチェックが行われない、update 等のメソッドを使用すると、password までバリデーションが行われてしまう。良い方法が見つからなかったので妥協。
    if flag && @current_user.update_attribute(:name, user_update_name_params[:name])
      redirect_to mypage_path, flash: { "success": t('shared.update-user-info') }
    else
      cause_some_error(error_message)
      redirect_with_error("name": user_update_name_params)
    end
  end

  def password_update
    user = User.find_by(id: session[:user_id])
    flag = true
    @current_user.attributes = user_update_name_params
    # ここで、error_messagesを取得してしまうと、下の処理により同じエラーが重複して表示されてしまうため、ここではフラグ追加
    flag = false unless @current_user.validate
    # 現在のパスワードが一致しているか
    if @current_user.authenticate(current_password_params[:current_password])
      # 現在のパスワードが一致していたら、次回以降入力の手間を省くためのフラグ
      password_flag = true
    else
      cause_some_error t('shared.wrong-current-password')
      flag = false
    end
    @current_user.attributes = user_update_params
    if @current_user.validate && flag
      @current_user.save
      redirect_to mypage_path, flash: { "success": t('shared.update-user-name-and-password') }
    else
      cause_some_error @current_user.errors.full_messages
      flash = { "name": user_update_name_params }
      flash[:current_password] = current_password_params[:current_password] if password_flag
      redirect_with_error flash
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

    def current_password_params
      # params.require(:user).permit(:name, :current_password, :password, :password_confirmation)
      params.require(:user).permit(:current_password)
    end
end
