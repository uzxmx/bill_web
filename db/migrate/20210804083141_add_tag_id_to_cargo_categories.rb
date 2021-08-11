class AddTagIdToCargoCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :cargo_categories, :tag_id, :integer
  end
end
