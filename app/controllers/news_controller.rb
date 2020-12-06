class NewsController < ApplicationController
  before_action :set_news, only: %i[show edit update]


  def index
    @news = News.all
  end

  def show
  end

  def new
    # 新規作成(create)が失敗したとき、空白にならないように、初期値を flash[:news] で渡す。
    @news = News.new(flash[:news])
  end

  def create
    news = News.new(news_params)
    if news.save
      flash[:success] = "#{news.title} の記事を作成しました"
      redirect_to news_index_path
    else
      flash[:error] = "#{news.errors.full_messages}"
      redirect_back fallback_location: root_path, flash: {
        error: "#{news.errors.full_messages}",
        news: news_params
      }
    end
  end

  def edit
    @news.attributes = flash[:news] if flash[:news]
  end

  def destroy
  end

  def update
    if @news.update(news_params)
      redirect_to @news, flash: { success: "#{@news.title} の記事を更新しました" }
    else
      redirect_back fallback_location: root_path, flash: {
        error: "#{@news.errors.full_messages}",
        news: news_params
      }
      # render :edit, flash: { error: "#{@news.errors.full_messages}" }
    end
  end

  private
    def news_params
      params.require(:news).permit(:title, :content, :summary)
    end

    def set_news
      @news = News.find(params[:id])
    end
end
