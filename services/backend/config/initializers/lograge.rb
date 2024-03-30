Rails.application.configure do
  break if %w[development test].include?(Rails.env)

  # Lograge config
  config.lograge.enabled = true

  # Set the controller class to the API controller
  config.lograge.base_controller_class = 'ActionController::API'

  # This specifies to log in JSON format
  config.lograge.formatter = Lograge::Formatters::Json.new

  # Disables log coloration
  config.colorize_logging = Rails.env.development?

  # Custom log info
  config.lograge.custom_options = lambda do |event|
    excluded_params = %w(controller action format)

    {}.tap do |hash|
      hash[:params] = event.payload.fetch(:params, {})
        .reject { |k| excluded_params.include?(k) }

      hash[:request_id] = event.payload[:request_id]
    end
  end
end
