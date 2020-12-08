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
end