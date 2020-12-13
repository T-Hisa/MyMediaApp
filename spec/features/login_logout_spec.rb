require 'rails_helper'

RSpec.feature "登録・サインイン・サインアウト", type: :feature do
  feature '日本語のみ調査' do
    scenario 'ユーザー登録後、きちんとマイページにリダイレクトされていること' do
      visit '/ja/users/new'
      fill_in 'ユーザー名', with: 'サンプル'
      fill_in 'Eメール', with: 'sample@sample.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード(確認)', with: 'password'
      click_on 'ユーザー登録'
      expect(page).to have_text 'ユーザー情報'
      # Toastメッセージも確認したかったけど、どうやらテストでは確認できない模様
    end
  
    context 'テスト前にユーザを作成しておく' do
      background do
        create(:sample_user)
      end
  
      scenario 'ログイン後、マイページに遷移すること' do
        visit 'ja/login'
        fill_in 'Eメール', with: 'sample@sample.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード(確認)', with: 'password'
        click_on 'ログイン'
        expect(page).to have_text 'ユーザー情報'
      end
    end
  
    context 'テスト前に、ユーザを作成し、ログインしておく' do
      background do
        create(:sample_user)
        visit '/ja/login'
        fill_in 'Eメール', with: 'sample@sample.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード(確認)', with: 'password'
        click_on 'ログイン'
      end
      scenario 'after logout, redirect to mypage' do
        click_on 'ログアウト'
        expect(page).not_to have_text '記事作成'
        # expect()
      end
    end
  end
end