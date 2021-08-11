class Api::CargoesController < Api::BaseController
  before_action :load_instance

  def index
    @cargoes = Cargo.where(workspace: current_workspace).order(created_at: :desc).page(page_params[:page]).per(page_params[:per])
  end

  def create
    @cargo = Cargo.create!(params.permit(:name, :note).merge(workspace: current_workspace))
    render :show
  end

  def update
    @cargo.update! cargo_params
    render :show
  end

  def destroy
    @cargo.destroy!
    render json: {}
  end

  private

  def load_instance
    @cargo = Cargo.where(workspace: current_workspace, id: params[:id]).first if params[:id].present?
  end

  def cargo_params
    params.permit(:name, :price, :note)
  end
end
