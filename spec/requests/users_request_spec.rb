require 'rails_helper'
require 'helpers/users_helper_spec'

RSpec.describe "Users", type: :request do
  include UsersTestHelper
  
  describe "POST create" do
    context "when given correct parameter" do
      let (:params) {
        { user: attributes_for(:correct_user) }
      }

      it "ユーザーモデルの数が1増えていること" do
        expect{ post '/ja/users/', params: params }.to change(User, :count).by(1)
      end

      it "user count increments by 1 when English" do
        expect{ post '/en/users/', params: params }.to change{ User.count }.by(1)
      end
    end

    context "when given empty-name parameter" do
      let (:empty_name_params) {
        { user: attributes_for(:empty_name_user) }
      }

      it 'user count do not change' do
        expect{ post '/ja/users', params: empty_name_params }.not_to change{ User.count }
      end

      it 'エラーメッセージに "ユーザー名を入力してください" が含まれていること' do
        post '/ja/users', params: empty_name_params
        expect(flash[:error]).to include 'ユーザー名を入力してください'
      end

      it "error_message includes `User Name can't be blank` when English" do
        post '/en/users', params: empty_name_params
        expect(flash[:error]).to include "User Name can't be blank"
      end
    end

    context "when given long-name parameter" do
      let (:long_name_params) {
        { user: attributes_for(:long_name_user) }
      }

      it 'user count do not change' do
        expect{ post '/ja/users', params: long_name_params }.not_to change{ User.count }
      end

      it 'エラーメッセージに "ユーザー名は16文字以内で入力してください" が含まれていること' do
        post '/ja/users', params: long_name_params
        expect(flash[:error]).to include 'ユーザー名は16文字以内で入力してください'
      end

      it "error_message includes 'User Name is too long (maximum is 16 characters)' when English" do
        post '/en/users', params: long_name_params
        expect(flash[:error]).to include "User Name is too long (maximum is 16 characters)"
      end
    end

    context "when given wrong-email parameter" do
      let (:invalid_email_params) {
        { user: attributes_for(:invalid_email_user) }
      }

      it 'user count do not change' do
        expect{ post '/ja/users', params: invalid_email_params }.not_to change{ User.count }
      end

      it 'エラーメッセージに "Eメールを正しい形式で入力してください" が含まれていること' do
        skip 'なぜか言語を切り替えても出力されるメッセージは初期言語状態に依存するのでペンディング'
        post '/ja/users', params: invalid_email_params
        expect(flash[:error]).to include "Eメールを正しい形式で入力してください"
      end
      
      it "error_message includes 'e-mail field: please input correct format' when English" do
        pending 'Even if the language is switched for some reason, the output message depends on the initial language, so it is pending.'
        post '/en/users', params: invalid_email_params
        expect(flash[:error]).to include "e-mail field: please input correct format"
      end
    end

    context "when given short-password parameter" do
      let (:short_password_params) {
        { user: attributes_for(:short_password_user) }
      }

      it 'user count do not change' do
        expect{ post '/ja/users', params: short_password_params }.not_to change{ User.count }
      end

      it 'エラーメッセージに "パスワードは6文字以上で入力してください" が含まれていること' do
        post '/ja/users', params: short_password_params
        expect(flash[:error]).to include "パスワードは6文字以上で入力してください"
      end

      it "error_message includes 'Password is too short (minimum is 6 characters)' when English" do
        post '/en/users', params: short_password_params
        expect(flash[:error]).to include "Password is too short (minimum is 6 characters)"
      end
    end

    context "when given not-match-password parameter" do
      let (:not_match_password_params) {
        { user: attributes_for(:not_match_password_user) }
      }

      it 'user count do not change' do
        expect{ post '/ja/users', params: not_match_password_params }.not_to change{ User.count }
      end

      it 'エラーメッセージに "パスワード(確認)とパスワードの入力が一致しません" が含まれていること' do
        post '/ja/users', params: not_match_password_params
        expect(flash[:error]).to include "パスワード(確認)とパスワードの入力が一致しません"
      end

      it "error_message includes 'Password Confirmation doesn't match Password' when English" do
        post '/en/users', params: not_match_password_params
        expect(flash[:error]).to include "Password Confirmation doesn't match Password"
      end
    end

    context "when given email is already registered" do
      before { create(:correct_user) }
      let (:correct_params) {
        { user: attributes_for(:correct_user) }
      }

      it "user count does not change" do
        expect{post '/ja/users/', params: correct_params }.not_to change{ User.count }
      end

      it 'エラーメッセージに "Eメールはすでに存在します" が含まれていること' do
        post '/ja/users', params: correct_params
        expect(flash[:error]).to include "Eメールはすでに存在します"
      end

      it "error_message includes 'e-mail has already been taken' が含まれていること" do
        post '/en/users', params: correct_params
        expect(flash[:error]).to include "e-mail has already been taken"
      end
    end
  end

  describe "PATCH update" do
    let (:user) { before_create_and_log_in }
    # テスト内で呼び出したら、Userの総数が変更してしまうので、テスト前に呼び出しておく
    before { user }

    context "when correct name parameter given" do
      let (:update_params) {
        { user: attributes_for(:update_name) }
      }

      it "user count does not change" do
        expect{patch "/ja/users/#{user.id}", params: update_params }.not_to change{ User.count }
      end

      it "user name update" do
        patch "/ja/users/#{user.id}", params: update_params
        expect(user.reload.name).to eq("update")
      end
    end

    context "when given empty-name parameter" do
      let (:update_empty_name) {
        { user: attributes_for(:update_empty_name) }
      }

      it 'エラーメッセージに "ユーザー名を入力してください" が含まれていること' do
        patch "/ja/users/#{user.id}", params: update_empty_name
        expect(flash[:error]).to include 'ユーザー名を入力してください'
      end

      it "error_message includes `User Name can't be blank` when English" do
        patch "/en/users/#{user.id}", params: update_empty_name
        expect(flash[:error]).to include "User Name can't be blank"
      end
    end

    context "when given long-name parameter" do
      let (:update_long_name) {
        { user: attributes_for(:update_long_name) }
      }

      it 'エラーメッセージに "ユーザー名は16文字以内で入力してください" が含まれていること' do
        patch "/ja/users/#{user.id}", params: update_long_name
        expect(flash[:error]).to include 'ユーザー名は16文字以内で入力してください'
      end

      it "error_message includes 'User Name is too long (maximum is 16 characters)' when English" do
        patch "/en/users/#{user.id}", params: update_long_name
        expect(flash[:error]).to include "User Name is too long (maximum is 16 characters)"
      end
    end
  end

  describe "PATCH password_update" do
    let (:user) { before_create_and_log_in }
    before { user }

    
    context "update:: when empty-name parameters given" do
      let (:update_empty_name_with_password) {
        { user: attributes_for(:update_empty_name_with_password) }
      }

      it 'エラーメッセージに "ユーザー名を入力してください" が含まれていること' do
        patch "/ja/update/password", params: update_empty_name_with_password
        expect(flash[:error]).to include 'ユーザー名を入力してください'
      end

      it "error_message includes `User Name can't be blank` when English" do
        patch "/en/update/password", params: update_empty_name_with_password
        expect(flash[:error]).to include "User Name can't be blank"
      end
    end

    context "update:: when wrong-password parameter given" do
      let (:update_with_wrong_password) {
        { user: attributes_for(:update_with_wrong_password) }
      }

      it "error_mmessage includes '現在のパスワードが間違っています' with Japanese" do
        patch "/ja/update/password", params: update_with_wrong_password
        expect(flash[:error]).to include "現在のパスワードが間違っています"
      end

      it "error_message includes 'Input Current Password Was Wrong' with English" do
        patch "/en/update/password", params: update_with_wrong_password
        expect(flash[:error]).to include "Input Current Password Was Wrong"
      end
    end

    context "update:: when not-match-password given" do
      let(:update_with_invalid_password) {
        { user: attributes_for(:update_with_invalid_password) }
      }

      it 'エラーメッセージに "パスワード(確認)とパスワードの入力が一致しません" が含まれていること' do
        patch "/ja/update/password", params: update_with_invalid_password
        expect(flash[:error]).to include "パスワード(確認)とパスワードの入力が一致しません"
      end

      it "error_message includes 'Password Confirmation doesn't match Password' when English" do
        patch "/en/update/password", params: update_with_invalid_password
        expect(flash[:error]).to include "Password Confirmation doesn't match Password"
      end
    end

    context "update:: when given short-password parameter" do
      let (:update_with_short_password) {
        { user: attributes_for(:update_with_short_password) }
      }

      it 'エラーメッセージに "パスワードは6文字以上で入力してください" が含まれていること' do
        patch "/ja/update/password", params: update_with_short_password
        expect(flash[:error]).to include "パスワードは6文字以上で入力してください"
      end

      it "error_message includes 'Password is too short (minimum is 6 characters)' when English" do
        patch "/en/update/password", params: update_with_short_password
        expect(flash[:error]).to include "Password is too short (minimum is 6 characters)"
      end
    end
  end
end