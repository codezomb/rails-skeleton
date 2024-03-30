# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

DEFAULT_URL_OPTIONS = {
  host: Rails.application.credentials.domain || 'localhost'
}.freeze

Rails.application.config.action_controller.default_url_options = DEFAULT_URL_OPTIONS
Rails.application.config.action_mailer.default_url_options = DEFAULT_URL_OPTIONS
Rails.application.routes.default_url_options = DEFAULT_URL_OPTIONS
