class ArticlesController< ApplicationController
  include ApplicationControllerHelper

  before_action :set_article, only: %i[show edit update destroy]
  before_action :logged_in?, except: :index

  def index
    @pagy, @articles = pagy(Article.all)
  end

  def show
  end

  def new
    # 新規作成(create)が失敗したとき、際表示されたページの入力欄が空白にならないように、初期値を flash[:article] で渡す。
    @article = @current_user.articles.new(flash[:article])
    # Article.new(flash[:article])
  end

  def create
    article = Article.new(article_params)
    if article.save
      article.image.attach(image_params[:image])
      flash[:success] = t('shared.created-article', title: article.title)
      redirect_to article
    else
      cause_some_error(t('shared.save-false')+t('shared.re-select-image')) if image_params[:image]
      cause_some_error(article.errors.full_messages)
      redirect_with_error({"article": article_params})
    end
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
    if @article.update(article_params)
      @article.image.attach(image_params[:image])
      redirect_to @article, flash: { success: t('shared.updated-article', title: @article.title) }
    else
      cause_some_error(t('shared.save-false')+t('shared.re-select-image')) if image_params[:image]
      cause_some_error(@article.errors.full_messages)
      redirect_with_error({"article": article_params})
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
end
