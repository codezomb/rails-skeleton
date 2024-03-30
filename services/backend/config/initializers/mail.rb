unless Rails.env.test?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    user_name: ENV.fetch('SMTP_USERNAME', ''),
    password:  ENV.fetch('SMTP_PASSWORD', ''),
    address:   ENV.fetch('SMTP_HOSTNAME', 'mail'),
    port:      ENV.fetch('SMTP_PORT', 1025)
  }
end
