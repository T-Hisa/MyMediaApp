class Api::ArticlesController < ApplicationController

  def index
    target = params[:target] ? params[:target] : "*"
    order_type = params[:order_type] ? params[:order_type] : "desc"
    order_target = params[:order_target] ? params[:order_target] : "id"
    query = "SELECT #{target} FROM articles WHERE isDraft = false ORDER BY #{order_target} #{order_type}"
    # 記事関係だからセキュリティ的にまずくはないと思うが、一応サニタイズする
    sanitized_query = Article.sanitize_sql([query])
    articles = Article.find_by_sql(sanitized_query)
    render json: { status: 'SUCCESS', message: 'Loaded posts', data: articles }
  end

  # 特定の記事のIDがわかっている場合はこっち
  def show
    article = Article.find_by(id: params[:id])
    render json: { status: 'SUCCESS', message: 'Loaded posts', data: article }
  end

  def current_user; end
  def not_admin?
    false
  end
end

