module UsersHelper
  def email_field_with_default_value(form)
    class_name = 'form-control'
    class_name << ' border-danger' if error_text_include?("Eメール")

    default_value = flash[:email] if flash[:email]
    tag.div class: 'form-group' do
      concat form.label :email, 'Eメール'
      concat form.email_field :email, value: default_value, class: class_name  
    end
  end

  def auto_password_field(form, type)
    class_name = 'form-control'
    class_name << ' border-danger' if error_text_include?("が一致しません")

    label_text = type == :password ? 'パスワード' : 'パスワード(確認)'
    tag.div class: 'form-group' do
      concat form.label type, label_text
      concat form.password_field type, class: class_name
    end
  end
end
