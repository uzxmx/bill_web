class CreateCargoCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :cargo_categories do |t|
      t.integer :cargo_id
      t.string :name
      t.float :price
      t.integer :count, default: 0
      t.text :note

      t.timestamps
    end
  end
end
