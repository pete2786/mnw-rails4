CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = Rails.application.secrets.aws_bucket_name
  config.aws_acl    = :public_read
  config.asset_host = Rails.application.secrets.aws_asset_host
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

  config.aws_credentials = {
    access_key_id:     Rails.application.secrets.aws_access_key_id,
    secret_access_key: Rails.application.secrets.aws_secret_access_key,
  }
end
