class NewsController < ApplicationController
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
      redirect_back(fallback_location: root_path)
      flash[:error] = "#{news.errors.full_messages}"
    end
  end

  def destroy
  end

  def update
  end

  private
    def news_params
      params.require(:news).permit(:title, :content, :summary)
    end
end
