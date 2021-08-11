module ExceptionUtils
  def halt(key, options = {})
    if options.delete(:prefix_key) { true }
      prefix = self.class.name.underscore.gsub('/', '.')
      if idx = prefix.rindex('_controller')
        prefix = prefix.slice(0, idx)
      end
      key = "#{prefix}.#{key}"
    end
    options[:status] ||= :bad_request
    raise RequestException.new(key, options)
  end

  def handle_exception(e)
    raise e if Rails.env.test? && ENV['debug'].present?

    backtrace = e.inspect + "\n" + e.backtrace.map { |line| "  " + line }.join("\n")
    logger.error backtrace

    case e
    when RequestException
      options = e.options
      extra = options[:extra]
      err = { reason: e.key.split('.').last }
      if I18n.exists?(e.key)
        err[:message] = I18n.t(e.key)
      end
      status = options[:status]
    when ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
      err = { reason: e.class.name.split('::').last }
      status = 400
    else
      err = { reason: 'Unknown' }
      status = 500
    end

    render json: { err: err }.merge(extra || {}), status: status
  end

  class RequestException < StandardError
    attr_reader :options

    def initialize(key, options = {})
      super(key)
      @options = options
    end

    alias :key :message
  end
end
