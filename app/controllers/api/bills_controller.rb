class Api::BillsController < Api::BaseController
  before_action :load_instance

  def index
    @bills = Bill.where(workspace: current_workspace).order(created_at: :desc).page(page_params[:page]).per(page_params[:per])
  end

  def create
    p = bill_params.merge(workspace: current_workspace)
    @bill = Bill.create!(p)
    render :show
  end

  def update
    @bill.update! bill_params
    render :show
  end

  def destroy
    @bill.destroy!
    render json: {}
  end

  private

  def load_instance
    @bill = Bill.where(workspace: current_workspace, id: params[:id]).first if params[:id].present?
  end

  def bill_params
    permitted = params.permit(:name, :bill_type, :amount, :actual_amount, :count, :billed_at, :tag)
    permitted[:actual_amount] ||= permitted[:amount]
    permitted
  end
end
