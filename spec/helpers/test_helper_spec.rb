module TestHelper
  def before_login
    create(:sample_user)
    visit '/ja/login'
    fill_in 'Eメール', with: 'sample@sample.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード(確認)', with: 'password'
    click_on 'ログイン'
  end

  def before_create
    create(:correct_user)
    create(:correct_article)
  end
end