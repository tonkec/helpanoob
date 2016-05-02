Devise.setup do |config|
  config.mailer_sender = 'noreply@helpanoob.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.secret_key = ENV['3c27c5ddc738ac03ffc6553406217f0de4d7b465c19252667af4192415d53e1bc2177d506fd36315dee1f96db658861c16b09cc0206fa6139ff93ca09a4c0944']
end

# config.secret_key = '3c27c5ddc738ac03ffc6553406217f0de4d7b465c19252667af4192415d53e1bc2177d506fd36315dee1f96db658861c16b09cc0206fa6139ff93ca09a4c0944'
