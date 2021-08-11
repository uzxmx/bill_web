class UpdateWorkspaceColumnOfWorkspaceRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_workspace_requests, :workspace
    add_column :user_workspace_requests, :workspace_id, :integer
  end
end
