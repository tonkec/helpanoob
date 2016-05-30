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
  config.secret_key = 'edc2c0c5a45cc5a2f9cc436649521f1744a1f295171c3577533b3ccb40cccce5e7b9e1104c2100d34d4aae768bdd2119cdb60bee3cb22816fe120309130d3e15'
  config.omniauth :github,  ENV['github_key'], ENV['github_secret'], scope: 'user,public_repo',
                  callback_url: "https://helpanoob.herokuapp.com/"
end