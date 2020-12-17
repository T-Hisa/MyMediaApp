require 'rails_helper'
require 'helpers/test_helper_spec'

RSpec.feature "他ユーザのページに訪れた時", type: :feature do
  include TestHelper

  background do
    before_login
  end
  scenario "他のユーザーの記事の詳細ページでは、編集・削除ボタンが表示されないこと" do
    article = create(:correct_article)
    visit "/ja/articles/#{ article.id }"
    expect(page).to_not have_selector "a", text: "削除"
    expect(page).to_not have_selector "a", text: "編集"
  end
end
