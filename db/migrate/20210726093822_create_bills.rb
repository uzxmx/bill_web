class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.integer :workspace_id
      t.string :name
      t.integer :bill_type
      t.float :amount
      t.float :actual_amount
      t.integer :cargo_category_id
      t.integer :count
      t.date :billed_at

      t.timestamps
    end
  end
end
