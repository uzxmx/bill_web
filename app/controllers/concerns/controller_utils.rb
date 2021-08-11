module ControllerUtils
  extend ActiveSupport::Concern

  included do
    helper_method :page_params
  end

  def page_params(max_page_size = 50)
    @page_params ||= {
      page: params[:page].try(:to_i) || 1,
      per: [
        [(params[:per] || params[:page_size]).try(:to_i) || 10, 1].max, max_page_size
      ].min
    }
  end
end
