class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.boolean :isAdmin, default: false
      t.references :favorite_news

      t.timestamps
    end
  end
end
