require 'rails_helper'
require 'helpers/test_helper_spec'

RSpec.feature "記事作成・編集周り", type: :feature do
  include TestHelper
  before do
    before_login
  end
  scenario "きちんと下書きとして保存されていること" do
    pending "きちんとテキストフィールドに値が入力されていることは確認できるが、コントローラ側でなぜかパラメータが渡ってきておらず失敗するのでpending"
    # jsが動作しないらしく、きちんとテスト自体が動作しても結局ダメ。
    visit "/ja/articles/new"
    fill_in "article_title", with: "sample"
    fill_in "article_content", with: "sample"
    click_on "下書き保存"
    binding.pry
    expect(page).to have_selector 'span', text: "下書き"
    visit "/ja/articles"
    expect(page).not_to have_selctor 'div.card', text: 'sample'
  end
  # scenario "きちんと作成されて投稿されていること"
  #   visit "/ja/articles/new"
  #   fill_in "article_title", with: "sample"
  #   fill_in "article_content", with: "sample"
  #   click_on "投稿"
  #   expect(page).to have_selector ''
  # end
end