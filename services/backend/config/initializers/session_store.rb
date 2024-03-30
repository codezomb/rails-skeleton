Rails.application.config.session_store :redis_store, key: '_hydra_session',
  expires_in: 1.day, servers: ["#{ENV['REDIS_URL']}/0/sessions"]
