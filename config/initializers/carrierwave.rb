require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

# CarrierWave.configure do |config|
  # config.storage :fog
  # config.fog_provider = 'fog/aws'
  # config.fog_directory  = 'studyplace-app'
  # config.fog_credentials = {
  #   provider: 'AWS',
  #   aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  #   aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  #   region: ENV['AWS_DEFAULT_REGION'],
  #   path_style: true
  # }
# end

  unless Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        region: ENV['AWS_DEFAULT_REGION']
      }
  
      config.fog_directory  = 'studyplace-app'
      config.cache_storage = :fog
    end
  end