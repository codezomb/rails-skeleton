host = ENV.fetch('REDIS_HOST', 'redis')
port = ENV.fetch('REDIS_PORT', '6379')
ENV['REDIS_URL'] = "redis://#{host}:#{port}"
