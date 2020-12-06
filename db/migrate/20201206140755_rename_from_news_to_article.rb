class RenameFromNewsToArticle < ActiveRecord::Migration[6.0]
  def change
    rename_table :news, :articles
  end
end
