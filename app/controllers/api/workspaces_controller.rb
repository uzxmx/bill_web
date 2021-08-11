class Api::WorkspacesController < Api::BaseController
  def index
    @workspaces = Workspace.left_joins(:user_workspaces).where('user_workspaces.user_id = ? OR creator_id = ?', current_user.id, current_user.id)
  end

  def create
    workspace = Workspace.find_by(name: params[:name])
    halt :err_already_exists if workspace
    @workspace = Workspace.create!(name: params[:name], creator: current_user)
    render :show
  end

  def join
    workspace = Workspace.find_by(name: params[:name])
    halt :err_not_exist unless workspace
    UserWorkspaceRequest.where(workspace: workspace, user: current_user, status: :initial).first_or_create!
    render json: {}
  end
end
