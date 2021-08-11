# frozen_string_literal: true

module ExceptionHandling
  extend ActiveSupport::Concern
  include ExceptionUtils

  included do
    rescue_from Exception, with: :handle_exception
  end
end
