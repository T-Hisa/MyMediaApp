require 'rails_helper'
require 'helpers/users_helper_spec'
require 'helpers/articles_helper_spec'

RSpec.describe "Articles", type: :request do
  include UsersTestHelper
  include ArticlesTestHelper

  describe "POST create" do

    # session[:user_id]に値を入れるか、login を済ましておかなければならない。
    let(:user) { before_create_and_log_in }

    context "when correct parameter given" do
      let (:correct_params) { article_params(user.id, attributes_for(:correct_article)) }

      it "article model count increments by 1" do
        expect{ post '/ja/articles', params: correct_params}.to change{Article.count}
      end
    end
    
    context "when long-title parameter given" do
      let(:long_title_params) { article_params(user.id, attributes_for(:long_title_article)) }
      
      it "article model count do not change" do
        expect{ post '/ja/articles', params: long_title_params}.not_to change{Article.count}
      end
      
      it "error_message includes 'タイトルは10文字以内で入力してください' when Japanese" do
        post '/ja/articles', params: long_title_params
        expect(flash[:error]).to include 'タイトルは10文字以内で入力してください'
      end
      
      it "error_message includes 'Title is too long (maximum is 10 characters)' when English" do
        post '/en/articles', params: long_title_params
        expect(flash[:error]).to include 'Title is too long (maximum is 10 characters)'
      end
    end

    context "when empty-title parameter given" do
      let(:empty_title_params) { article_params(user.id, attributes_for(:empty_title_article))}

      it "article model count do not change" do
        expect{ post '/ja/articles', params: empty_title_params}.not_to change{Article.count}
      end
      
      it "error_message includes 'タイトルを入力してください' when Japanese" do
        post '/ja/articles', params: empty_title_params
        expect(flash[:error]).to include 'タイトルを入力してください'
      end
      
      it "error_message includes 'Title can't be blank' when English" do
        post '/en/articles', params: empty_title_params
        expect(flash[:error]).to include "Title can't be blank"
      end
    end

    context "when empty-content parameter given" do
      let(:empty_content_params) { article_params(user.id, attributes_for(:empty_content_article)) }

      it "article model count do not change" do
        expect{ post '/ja/articles', params: empty_content_params}.not_to change{Article.count}
      end
      
      it "error_message includes '本文を入力してください' when Japanese" do
        post '/ja/articles', params: empty_content_params
        expect(flash[:error]).to include '本文を入力してください'
      end
      
      it "error_message includes 'Content can't be blank' when English" do
        post '/en/articles', params: empty_content_params
        expect(flash[:error]).to include "Content can't be blank"
      end
    end
  end

  describe "PATCH update" do
    let(:article) { create(:correct_article) }
    
    before do
      # テスト内で呼び出したら、全体のArticleの数が変更してしまうので、テスト前に作成しておく

      article
      before_log_in
    end

    context "when correct parameter given" do
      let (:correct_params) { article_params(article.user_id, attributes_for(:correct_article)) }

      it "article model count does not change" do
        expect{ patch "/ja/articles/#{article.id}", params: correct_params}.not_to change{Article.count}
      end
    end

    context "when long-title parameter given" do
      let(:long_title_params) { article_params(article.user_id, attributes_for(:long_title_article)) }
      
      it "article model count do not change" do
        expect{ patch "/ja/articles/#{article.id}", params: long_title_params}.not_to change{Article.count}
      end
      
      it "error_message includes 'タイトルは10文字以内で入力してください' when Japanese" do
        patch "/ja/articles/#{article.id}", params: long_title_params
        expect(flash[:error]).to include 'タイトルは10文字以内で入力してください'
      end
      
      it "error_message includes 'Title is too long (maximum is 10 characters)' when English" do
        patch "/en/articles/#{article.id}", params: long_title_params
        expect(flash[:error]).to include 'Title is too long (maximum is 10 characters)'
      end
    end

    context "when empty-title parameter given" do
      let(:empty_title_params) { article_params(article.user_id, attributes_for(:empty_title_article)) }

      it "article model count do not change" do
        expect{ patch "/ja/articles/#{article.id}", params: empty_title_params}.not_to change{Article.count}
      end
      
      it "error_message includes 'タイトルを入力してください' when Japanese" do
        patch "/ja/articles/#{article.id}", params: empty_title_params
        expect(flash[:error]).to include 'タイトルを入力してください'
      end
      
      it "error_message includes 'Title can't be blank' when English" do
        patch "/en/articles/#{article.id}", params: empty_title_params
        expect(flash[:error]).to include "Title can't be blank"
      end
    end

    context "when empty-content parameter given" do
      let(:empty_content_params) { article_params(article.user_id, attributes_for(:empty_content_article)) }

      it "article model count do not change" do
        expect{ patch "/ja/articles/#{article.id}", params: empty_content_params}.not_to change{Article.count}
      end
      
      it "error_message includes '本文を入力してください' when Japanese" do
        patch "/ja/articles/#{article.id}", params: empty_content_params
        expect(flash[:error]).to include '本文を入力してください'
      end
      
      it "error_message includes 'Content can't be blank' when English" do
        patch "/en/articles/#{article.id}", params: empty_content_params
        expect(flash[:error]).to include "Content can't be blank"
      end
    end
  end
end
