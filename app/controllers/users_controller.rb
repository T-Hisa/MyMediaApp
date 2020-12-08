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
    @current_user.attributes = flash[:name] if flash[:name]
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
    user = User.find_by(id: session[:user_id])
    error_messages = []
    flag = true
    @current_user.attributes = user_update_name_params
    # ここで、error_messagesを取得してしまうと、下の処理で同じエラーが重複してしまうため、ここではフラグ追加
    flag = false unless @current_user.validate
    # 現在のパスワードが一致しているか
    if @current_user.authenticate(current_password_params[:current_password])
      # 現在のパスワードが一致していたら、次回以降入力の手間を省くためのフラグ
      password_flag = true
    else
      error_messages << "現在のパスワードが間違っています"
      flag = false
    end
    # 新規パスワード欄が空白か。これを行わないと、password と password_confirmation が空白の時、name カラムのみ更新処理を行ってしまう
    if user_update_params[:password].empty?
      error_messages << "新規パスワード欄に記入してください"
      flag = false
    end
    # 最終チェック。validateを先にしているのは、flagが優先されてしまわないようにするためため（そういう挙動だったはず）。
    @current_user.attributes = user_update_params
    if @current_user.validate && flag
      @current_user.save
      redirect_to mypage_path, flash: { "success": "ユーザー情報を更新しました。パスワードが変更されたことにご注意ください" }
    else
      # ※注意 errors.full_messages が配列なので、『<<』記法では二重([[]])となってしまう。
      error_messages.concat @current_user.errors.full_messages unless @current_user.errors.full_messages.empty?
      flash = {
        "error": error_messages,
        "name": user_update_name_params
      }
      flash["current_password"] = current_password_params[:current_password] if password_flag
      redirect_back fallback_location: root_path, flash: flash
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
