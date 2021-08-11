class CreateUserWorkspaceRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :user_workspace_requests do |t|
      t.integer :user
      t.integer :workspace
      t.integer :status

      t.timestamps
    end
  end
end
