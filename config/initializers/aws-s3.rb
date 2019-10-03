require 'aws-sdk-s3'

if ESSI.config[:aws]
  Aws.config.update(
    endpoint: ESSI.config[:aws][:endpoint],
    access_key_id: ESSI.config[:aws][:access_key_id],
    secret_access_key: ESSI.config[:aws][:secret_access_key],
    force_path_style: true,
    region: ESSI.config[:aws][:region]
  )
end
