CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['AWS_S3_REGION'],
    path_style: true
  }

  config.fog_directory = ENV['S3_BUCKET_NAME'] 
  config.fog_public     = false  # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'} 

  # For testing, upload files to local `tmp` folder.
  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end


 
end