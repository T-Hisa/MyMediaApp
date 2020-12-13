module UsersTestHelper
  def before_create_and_log_in
    user = create(:correct_user)
    params = {
      session: attributes_for(:login_params)
    }
    post '/ja/login', params: params
    user
  end

  def before_log_in
    params = {
      session: attributes_for(:login_params)
    }
    post '/ja/login', params: params
  end
  
end
