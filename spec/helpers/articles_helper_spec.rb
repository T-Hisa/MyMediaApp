module ArticlesTestHelper
  def article_params(user_id, article_params)
    # FactoryBotが提供しているAPIに DBを作成せずに、Article と User を紐づけるような物がなかったので、直接user_idを指定している。
    params = {}
    params[:article] = article_params
    params[:article][:user_id] = user_id
    params
  end
end