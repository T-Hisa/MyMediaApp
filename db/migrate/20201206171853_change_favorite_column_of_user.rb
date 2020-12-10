class ChangeFavoriteColumnOfUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :favorite_news_id
    # add_column :users, :favorite_articles, :integer
    # change_column :users, :favorite_news_id, :favorite_articles, 
  end
end
