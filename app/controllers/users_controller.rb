class UsersController < ApplicationController
  include ApplicationControllerHelper
  include SessionCreateHelper
  before_action :already_login?, only: %i(new login)
  before_action :logged_in?, only: [:mypage, :edit, :update, :password_update]
  def new
    @user = User.new(flash[:user_params])
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      params[:user][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_to mypage_path, flash: { "success": t('shared.welcome', name: user.name) }
    else
      # UsersControllerHelper で定義してあるメソッド
      cause_some_error(user.errors.full_messages)
      redirect_with_error("user_params": user_params)
    end
  end

  def login; end

  def mypage
    articles = @current_user.articles.where(isDraft: false)
    favorite_articles = @current_user.favorite_articles
    draft_articles = @current_user.articles.where(isDraft: true)
    @pagy, @articles = generate_pagy(articles, 1)
    @pagy_for_favorite, @favorite_articles = generate_pagy(favorite_articles, 2)
    @pagy_for_draft, @draft_articles = generate_pagy(draft_articles, 3)
  end

  def edit
    @current_user.attributes = flash[:name] if flash[:name]
  end

  def update
    # update_attribute で更新しようとすると、validationチェックが行われないので、
    # 名前欄が空白・長すぎる場合は、モデルのバリデーションと同等のエラーメッセージを手動で表示するようにする
    flag, error_message = user_name_validation
    # バリデーションチェックが行われない、update 等のメソッドを使用すると、password までバリデーションが行われてしまう。良い方法が見つからなかったので妥協。
    if flag && @current_user.update_attribute(:name, user_update_name_params[:name])
      redirect_to mypage_path, flash: { "success": t('shared.update-user-info') }
    else
      cause_some_error(error_message)
      redirect_with_error("name": user_update_name_params)
    end
  end

  def password_update
    password_flag = true
    # ここで、error_messagesを取得してしまうと、下の処理により同じエラーが重複して表示されてしまうため、ここではフラグ追加
    flag, = user_name_validation
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

    # モデルを直接『update, validate』などで検証すると、『password』の検証もされてしまうので、ここで検証する
    def user_name_validation
      flag = true
      error_message = ""
      if user_update_name_params[:name].empty?
        flag = false
        error_message = t('shared.name_blank')
      elsif user_update_name_params[:name].length > 16
        flag = false
        error_message = t('shared.name_too_long')
      end
      [flag, error_message]
    end

    def calculate_page_count(count)
      # 対象の記事がなかった場合に、params[:page]が0となってしまいエラーが発生するので、1を代入
      count == 0 ? 1 : (count - 1) / 6 + 1
    end

    def generate_pagy(articles, flag)
      # ページネーションが行われている かつ
      # その値が、記事数を6で割った商より大きければ、いつも通りページネーションする。でなければその差分デクリメントする
      case flag
      # 渡された値(flag)によってページング対象のパラメータを動的に設定する
      when 1
        Pagy::VARS[:page_param] = :page_1
        param_flag = :page_1
      when 2
        Pagy::VARS[:page_param] = :page_2
        param_flag = :page_2
      when 3
        Pagy::VARS[:page_param] = :page_3
        param_flag = :page_3
      end
      if params[param_flag]
        page_params = params[:page_1].to_i
        if (sub = page_params - calculate_page_count(articles.count)) < 0
          pagy(articles)
        else
          params[:page_1] = page_params - sub
          pagy(articles)
        end
      else
        pagy(articles)
      end
    end
end
