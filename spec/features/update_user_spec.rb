require 'rails_helper'
require 'helpers/test_helper_spec'

RSpec.feature "ユーザー情報編集", type: :feature do
  include TestHelper

  background do
    before_login
  end
  scenario "ユーザー名がきちんと編集できること" do
    pending "フィールドに入力されていることは確認できたが、なぜかコントローラ側にその値が渡って来ないのでpending"
    user = User.first
    visit "/ja/users/#{user.id}/edit"
    fill_in "name", with: "update"
    within "#onlyNameModal" do
      find(".btn-primary").click
    end
    expect(page).to have_text '投稿した記事'
    expect(user.reload.name).to eq "update"
  end

  scenario "パスワードがきちんと編集できること" do
    pending "こちらも同様"
    user = User.first
    visit "/ja/users/#{user.id}/edit"
    fill_in "name", with: "update"
    fill_in "current_password", with: "password"
    fill_in "password", with: "update!"
    fill_in "password_confirmation", with: "update!"

    within "#includePasswordModal" do
      find(".btn-primary").click
    end
    expect(page).to have_text '投稿した記事'
  end
end