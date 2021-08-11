class AddColumnsToCargoCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :cargo_categories, :photo, :string
    add_column :cargo_categories, :parent_id, :integer
    add_column :cargo_categories, :level, :integer, default: 0
  end
end
