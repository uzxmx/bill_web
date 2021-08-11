class Api::BaseController < ApplicationController
  include ControllerUtils
  include ExceptionHandling

  before_action :set_format
  before_action :ward_by_user!

  helper_method :current_workspace

  private

  def set_format
    request.format = 'json'
  end

  def current_workspace
    @current_workspace ||= Workspace.left_joins(:user_workspaces).where('user_workspaces.user_id = ? OR creator_id = ?', current_user.id, current_user.id).first
  end
end
