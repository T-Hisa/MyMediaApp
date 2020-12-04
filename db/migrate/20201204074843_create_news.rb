class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.boolean :isDeleted, default: false
      t.boolean :isDraft, default: false

      t.timestamps
    end
  end
end
