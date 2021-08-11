class CreateWorkspaces < ActiveRecord::Migration[6.0]
  def change
    create_table :workspaces do |t|
      t.integer :creator_id
      t.string :name

      t.timestamps
    end
  end
end
