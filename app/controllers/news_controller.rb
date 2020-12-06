class NewsController < ApplicationController
  before_action :set_news, only: %i[show edit update]


  def index
    @news = News.all
  end

  def show
  end

  def new
    @news = News
  end

  def create
    news = News.new(news_params)
    if news.save
      flash[:success] = "#{news.title} の記事を作成しました"
      redirect_to news_index_path
    else
      flash[:error] = "#{news.errors.full_messages}"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
  end

  def destroy
  end

  def update
    if News.update(news_params)
      redirect_to @news
    else
      redirect_back(fallback_location: root_path)
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
