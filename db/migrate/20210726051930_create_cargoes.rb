class CreateCargoes < ActiveRecord::Migration[6.0]
  def change
    create_table :cargoes do |t|
      t.integer :workspace_id
      t.string :name
      t.float :price
      t.text :note

      t.timestamps
    end
  end
end
