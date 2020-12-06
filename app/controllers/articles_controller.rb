class ArticlesController< ApplicationController
  before_action :set_article, only: %i[show edit update]


  def index
    @articles = Article.all
  end

  def show
  end

  def new
    # 新規作成(create)が失敗したとき、空白にならないように、初期値を flash[:article] で渡す。
    @article = Article.new(flash[:article])
  end

  def create
    article = Article.new(article_params)
    if article.save
      flash[:success] = "#{article.title} の記事を作成しました"
      redirect_to article_index_path
    else
      flash[:error] = "#{article.errors.full_messages}"
      redirect_back fallback_location: root_path, flash: {
        error: "#{article.errors.full_messages}",
        article: article_params
      }
    end
  end

  def edit
    @article.attributes = flash[:article] if flash[:article]
  end

  def destroy
  end

  def update
    if @article.update(article_params)
      redirect_to @article, flash: { success: "#{@article.title} の記事を更新しました" }
    else
      redirect_back fallback_location: root_path, flash: {
        error: "#{@article.errors.full_messages}",
        article: article_params
      }
      # render :edit, flash: { error: "#{@article.errors.full_messages}" }
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :content, :summary)
    end

    def set_article
      @article = Article.find(params[:id])
    end
end
