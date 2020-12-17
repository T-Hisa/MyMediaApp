class RemoveIsDeleteColumnFromArticles < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :isDeleted
  end
end
