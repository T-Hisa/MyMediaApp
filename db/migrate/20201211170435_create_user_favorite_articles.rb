class CreateUserFavoriteArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_favorite_articles do |t|
      t.integer :user_id
      t.integer :article_id

      t.timestamps
    end
  end
end
