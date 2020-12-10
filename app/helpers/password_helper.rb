module PasswordHelper

  def auto_password_field(form)
    tag.div do
      2.times do |i|
        concat (tag.div class: 'form-group' do
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
        concat (tag.div class: 'form-group' do

          label_text, flag, type, id_name = i == 0 ? 
            [t('.password'), /パスワード.+入/ , :password, 'password'] : [t('.password-confirmation'), /パスワード\(確認\)/, :password_confirmation, 'password_confirmation']
          class_name = 'form-control'
          class_name << ' border-danger' if error_text_include?(flag)
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