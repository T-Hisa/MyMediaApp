class Api::UsersController < ApplicationController
  include ApplicationControllerHelper
  def edit
    user = User.find_by(id: params[:id])
    render json: user
  end

  def update
    # flag, error_message = user_name_validation
    # バリデーションチェックが行われない、update 等のメソッドを使用すると、password までバリデーションが行われてしまう。良い方法が見つからなかったので妥協。
    flag, error_message = user_name_validation
    if flag && @current_user.update_attribute(:name, user_update_name_params[:name])
      render json: {
        url: mypage_path,
        # flash: { "success": t('shared.update-user-info') }
      }, flash: { "success": t('shared.update-user-info') }
    else
      cause_some_error(error_message)
      redirect_with_error("name": user_update_name_params)
    end
  end

  private
    def user_update_name_params
      params.require(:user).permit(:name)
    end

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
end