class Api::TagsController < Api::BaseController
  before_action :load_instance

  def index
    @tags = WorkspaceTag.where(workspace: current_workspace, tag_type: params[:tag_type])
  end

  def create
    @tag = WorkspaceTag.create!(params.permit(:name, :tag_type, :value).merge(workspace: current_workspace))
    render 'show'
  end

  def update
    @tag.update! params.permit(:name, :value)
    render 'show'
  end

  def destroy
    @tag.destroy!
    render json: {}
  end

  private

  def load_instance
    @tag = WorkspaceTag.where(workspace: current_workspace, id: params[:id]).first if params[:id].present?
  end
end
