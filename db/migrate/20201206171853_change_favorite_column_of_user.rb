class ChangeFavoriteColumnOfUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :favorite_news_id
    add_column :users, :favorite_article_ids, :int
  end
end
