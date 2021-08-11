class CreateUserWorkspaces < ActiveRecord::Migration[6.0]
  def change
    create_table :user_workspaces do |t|
      t.integer :workspace_id
      t.integer :user_id

      t.timestamps
    end
  end
end
