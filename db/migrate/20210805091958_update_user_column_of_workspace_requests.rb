class UpdateUserColumnOfWorkspaceRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_workspace_requests, :user
    add_column :user_workspace_requests, :user_id, :integer
  end
end
