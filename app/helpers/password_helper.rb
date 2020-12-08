module PasswordHelper
  # こちらは念のためコメントアウトで残しておく

  # def auto_password_field(form, type)
  #   class_name = 'form-control'
  #   # error_text の認証に使用するものと　viewに表記する『labe_text』が同一の文字列で十分なので、以下のように定義する。後に別々で定義にするかも？
  #   label_text = type == :password ? 'パスワード' : 'パスワード(確認)'
  #   class_name << ' border-danger' if error_text_include?(label_text)

  #   tag.div class: 'form-group' do
  #     concat form.label type, label_text
  #     concat form.password_field type, class: class_name
  #   end
  # end

  def auto_password_field(form)
    tag.div do
      2.times do |i|
        concat (tag.div class: 'form-group' do
          label_text = i == 0 ? 'パスワード' : 'パスワード(確認)'
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
            ['新規パスワード', /パスワード.+入/ , :password, 'password'] : ['パスワード(確認)', /パスワード\(確認\)/, :password_confirmation, 'password_confirmation']
          class_name = 'form-control'
          class_name << ' border-danger' if error_text_include?(flag)
          concat form.label type, label_text
          concat form.password_field type, class: class_name, id: id_name
        end)
      end
    end
  end

  def current_password_field_for_edit(form)
    label_text = '現在のパスワード'
    class_name = 'form-control'
    class_name << ' border-danger' if error_text_include?(label_text)
    default_value = flash[:current_password]
    tag.div class: 'form-group' do
      concat form.label :current_password, label_text
      concat form.password_field :current_password, value: default_value, class: class_name, id: 'current_password'
    end
  end
end