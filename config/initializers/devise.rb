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
  config.secret_key = '865768315e884b88c97bfb84c1ab09f0d634b682fe76c526792fb08c8ec871af0ffa04f4434b0a772cdb09cd749ceeb18de854c57bfc24fece157ff06423b5a4'

end