class Api::CargoCategoriesController < Api::BaseController
  before_action :load_instance

  def create
    cargo = Cargo.where(workspace: current_workspace, id: params[:cargo_id]).first
    create_params = category_params.merge(cargo: cargo)
    if params[:parent_id].present?
      parent = CargoCategory.where(id: params[:parent_id], cargo: cargo).first
      create_params.merge! parent: parent
    end
    @cargo_category = CargoCategory.create!(create_params)
    render 'show'
  end

  def update
    @cargo_category.update! category_params
    render 'show'
  end

  def update_count
    count =  @cargo_category.count || 0
    create_bill = params[:create_bill].present?

    delta = params[:delta].to_i
    if params[:action_type] == 'incr'
      count += delta
      bill_type = :spend
    else
      count -= delta
      bill_type = :income
    end

    halt :err_invalid_count if count < 0

    CargoCategory.transaction do
      @cargo_category.update! count: count
      if create_bill
        name = @cargo_category.cargo.name
        if @cargo_category.parent&.name.present?
          name = "#{name} - #{@cargo_category.parent.name}"
        end
        if @cargo_category.name.present?
          name = "#{name} - #{@cargo_category.name}"
        end

        bill_params = params[:bill]

        Bill.create!(
          workspace: current_workspace,
          bill_type: bill_type,
          name: name,
          amount: bill_params[:amount],
          actual_amount: bill_params[:actual_amount] || bill_params[:amount],
          count: delta,
          cargo_category: @cargo_category,
          billed_at: bill_params[:billed_at]
        )
      end
    end

    render json: {}
  end

  def destroy
    @cargo_category.destroy!
    render json: {}
  end

  private

  def load_instance
    @cargo_category = CargoCategory.where(id: params[:id], cargo_id: Cargo.where(workspace: current_workspace).pluck(:id)).first if params[:id].present?
  end

  def category_params
    p = params.permit(:name, :photo, :price, :count, :note)
    if params[:tag_id].present?
      p.merge! tag: WorkspaceTag.where(workspace: current_workspace, id: params[:tag_id]).first
    end
    p
  end
end
