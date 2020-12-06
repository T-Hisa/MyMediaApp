class AddSummaryToNews < ActiveRecord::Migration[6.0]
  def change
    add_column :news, :summary, :string
  end
end
