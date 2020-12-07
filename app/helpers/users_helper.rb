module UsersHelper
  # error_text_include? メソッドは、application_helper.rb ファイル参照
  
  def auto_email_field(form)
    class_name = 'form-control'
    class_name << ' border-danger' if error_text_include?("Eメール")

    tag.div class: 'form-group' do
      concat form.label :email, 'Eメール'
      # サインイン フォームでは、flash[:email] を使用して、失敗時にデフォルトでセットされるようにする。
      concat form.email_field :email, value: flash[:email], class: class_name  if flash[:email]
      # サインアップ フォームでは、そのままparams[:user][:email]を取得しているのでこっち
      concat form.email_field :email, class: class_name if !flash[:email]
    end
  end

  def auto_password_field(form, type)
    class_name = 'form-control'
    # label_text, judgement_type = type == :password ? 
    #   ['パスワード', 'パスワード'] : ['パスワード(確認)', 'が一致しません']
    # class_name << ' border-danger' if error_text_include?(judgement_type)
    label_text = type == :password ? 'パスワード' : 'パスワード(確認)'
    class_name << ' border-danger' if error_text_include?(label_text)

    tag.div class: 'form-group' do
      concat form.label type, label_text
      concat form.password_field type, class: class_name
    end
  end

  def auto_name_field(form)
    class_name = 'form-control'
    class_name << ' border-danger' if error_text_include?("ユーザー")
    
    tag.div class:'form-group' do
      concat form.label :name, 'ユーザー名'
      concat form.text_field :name, class: class_name
    end
  end
end
