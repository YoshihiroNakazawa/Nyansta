CarrierWave.configure do |config|
  #config.cache_dir = "/tmp/uploads/cache/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #config.root = Rails.root#'/home/vagrant/uploads_tmp/tmp'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['AWS_REGION'],
    path_style: true
  }
  config.fog_public     = true # public-read

  config.remove_previously_stored_files_after_update = false

  config.fog_directory = ENV['AWS_S3_BUCKET']
  config.asset_host = ENV['AWS_S3_URL']
  config.cache_storage = :fog
end
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
