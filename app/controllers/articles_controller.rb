class ArticlesController < ApplicationController
  include ApplicationControllerHelper
  before_action :set_article, only: [:show, :edit, :update, :destroy, :favorite]
  before_action :logged_in?, except: :index

  def index
    decide_search_text
  end

  def show; end

  def new
    # 新規作成(create)が失敗したとき、際表示されたページの入力欄が空白にならないように、初期値を flash[:article] で渡す。
    @article = @current_user.articles.new(flash[:article])
    # Article.new(flash[:article])
  end

  def create
    @article = Article.new(article_params)
    create_article
  end

  def draft_create
    @article = Article.new(article_params)
    @article.isDraft = true
    create_article
  end

  def favorite
    if @current_user.favorite_articles.include?(@article)
      @current_user.favorite_articles.delete(@article)
    else
      @current_user.favorite_articles.push(@article)
    end
    render
  end

  def edit
    @article.attributes = flash[:article] if flash[:article]
  end

  def destroy
    @article.delete
    redirect_to articles_path, flash: {
      "info": t('shared.deleted-article', title: @article.title)
    }
  end

  def update
    @article.isDraft = url_for.include?('draft') ? true : false
    if @article.update(article_params)
      @article.image.attach(image_params[:image])
      redirect_to @article, flash: { success: t('shared.updated-article', title: @article.title) }
    else
      cause_some_error(t('shared.save-false') + t('shared.re-select-image')) if image_params[:image]
      cause_some_error(@article.errors.full_messages)
      redirect_with_error({ "article": article_params })
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :summary, :user_id)
  end

  def image_params
    params.require(:article).permit(:image)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def search_params
    params[:title]
  end

  def decide_search_text
    Pagy::VARS[:page_param] = :page
    if search_params
      case params[:search_type]
      when "0"
        search_text = "%#{search_params}%"
      when "1"
        search_text = "#{search_params}%"
      when "2"
        search_text = "%#{search_params}"
      when "3"
        search_text = search_params.to_s
      end
      @pagy, @articles = pagy(Article.where("isDraft = false AND title LIKE ?", search_text))
    else
      # デフォルト
      @pagy, @articles = pagy(Article.where('isDraft = false'))
    end
  end

  def create_article
    if @article.save
      @article.image.attach(image_params[:image])
      flash[:success] = t('shared.created-article', title: @article.title)
      redirect_to @article
    else
      cause_some_error(t('shared.save-false') + t('shared.re-select-image')) if image_params[:image]
      cause_some_error(@article.errors.full_messages)
      redirect_with_error({ "article": article_params })
    end
  end
end
