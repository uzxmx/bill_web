class Api::WorkspaceRequestsController < Api::BaseController
  def index
    if params[:as] == 'applicant'
      @workspace_requests = UserWorkspaceRequest.where(user: current_user).order(created_at: :desc)
      render 'index_for_applicant'
    elsif params[:as] == 'workspace_owner'
      if current_workspace.creator == current_user
        @workspace_requests = UserWorkspaceRequest.where(workspace: current_workspace).order(created_at: :desc)
      else
        @workspace_requests = []
      end
      render 'index_for_workspace_owner'
    else
      halt :err_invalid_as_param
    end
  end

  def update
    halt :err_forbidden unless current_workspace.creator == current_user
    req = UserWorkspaceRequest.find_by(workspace: current_workspace, id: params[:id])
    halt :err_cannot_update_status unless req.status.nil? || req.initial?
    UserWorkspaceRequest.transaction do
      req.update! status: params[:status]
      UserWorkspace.create! workspace: current_workspace, user: req.user if req.allowed?
    end
    render json: {}
  end
end
