module ApplicationControllerHelper
  @@error_messages = []
  def cause_some_error(message)
    # 空の配列が渡された時に、『[]』というエラーメッセージが含まれてしまう
    if message.present?
      if message.class == Array
        # 配列でエラーメッセージが渡された時は、一つ一つ追加していく
        message.each do |m|
          @@error_messages << m
        end
      else
        @@error_messages << message
      end
    end
  end

  def redirect_with_error(params, path: root_path)
    params["error"] = @@error_messages
    redirect_back fallback_location: path, flash: params
    @@error_messages = []
  end

  module_function :cause_some_error, :redirect_with_error
end