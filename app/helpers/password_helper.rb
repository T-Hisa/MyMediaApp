module PasswordHelper
  def auto_password_field(form)
    tag.div do
      2.times do |i|
        concat(tag.div class: 'form-group' do
          label_text = i == 0 ? t('.password') : t('.password-confirmation')
          type = i == 0 ? :password : :password_confirmation
          class_name = 'form-control'
          class_name << ' border-danger' if error_text_include?(label_text)
          concat form.label type, label_text
          concat form.password_field type, class: class_name
        end)
      end
    end
  end

  def auto_password_field_for_edit(form)
    tag.div do
      2.times do |i|
        concat(tag.div class: 'form-group' do
          label_text, type, id_name = if i == 0
            [t('.password'), :password, 'password']
          else
           [t('.password-confirmation'), :password_confirmation, 'password_confirmation']
          end
          class_name = 'form-control'
          case I18n.locale.to_s
          when "ja"
              flag_text = i == 0 ? /パスワード.+入力/ : /パスワード\(確認\)/
              flag = error_text_include?(flag_text)
          when "en"
              # 英語の場合、new password の欄で判定できる条件ができないので、複数回に渡ってフラグ判定を行う。
              if i == 0
                flag_text_1 = /password\sis/i
                flag_text_2 = /match\spassword/i
                flag = error_text_include?(flag_text_1) || error_text_include?(flag_text_2)
              else
                flag_text = /password\sconfirmation/i
                flag = error_text_include?(flag_text)
              end
          end
          class_name << ' border-danger' if flag
          concat form.label type, label_text
          concat form.password_field type, class: class_name, id: id_name
        end)
      end
    end
  end

  def current_password_field_for_edit(form)
    label_text = t('.current-password')
    class_name = 'form-control'
    class_name << ' border-danger' if error_text_include?(label_text)
    default_value = flash[:current_password]
    tag.div class: 'form-group' do
      concat form.label :current_password, label_text
      concat form.password_field :current_password, value: default_value, class: class_name, id: 'current_password'
    end
  end
end
