class Admin::ArticlesController < ApplicationController
  before_action :is_admin?

  def index
    @articles = Article.all
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy!
    redirect_to admin_articles_path
  end

  private
    def not_admin?
      false
    end
    
    def is_admin?
      redirect_to root_path unless @current_user.isAdmin
    end
end