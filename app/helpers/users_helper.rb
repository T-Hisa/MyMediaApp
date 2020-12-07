module UsersHelper
  # error_text_include? メソッドは、application_helper.rb ファイル参照
  
  def auto_email_field(form)
    class_name = 'form-control'
    class_name << ' border-danger' if error_text_include?("Eメール")
    
    # 編集ページでは、ユーザー情報を初期値として渡すので、こちらの処理。
    default_value = @current_user.email if @current_user.present?
    # サインイン フォームでは、flash[:email] を使用して、失敗時にデフォルトでセットされるのでこちらの処理
    default_value = flash[:email] if flash[:email]
    # サインアップ フォームでは、そのまま(失敗して再表示の際に)params[:user][:email]を取得しているので何もセットしない。

    tag.div class: 'form-group' do
      concat form.label :email, 'Eメール'
      concat default_value.present? ?
         (form.email_field :email, value: default_value, class: class_name) :
         (form.email_field :email, class: class_name)
    end
  end

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

  def auto_name_field(form)
    parent_class_name = 'form-group'
    parent_class_name << ' user-edit-form' if @current_user && current_page?(edit_user_path(@current_user))
    class_name = 'form-control'
    class_name << ' border-danger' if error_text_include?("ユーザー")

    # default_value = @current_user.name if ? @current_user.present?
    tag.div class: parent_class_name do
      concat form.label :name, 'ユーザー名'
      concat @current_user.present? ?
        (form.text_field :name, value: @current_user.name, class: class_name) :
        (form.text_field :name, class: class_name)
    end
  end
end
