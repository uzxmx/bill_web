class Api::UploadTokensController < ApplicationController
  def create
    policy = Qiniu::Auth::PutPolicy.new(Settings.qiniu.image.bucket, SecureRandom.uuid.gsub('-', ''), 3600)
    token = Qiniu::Auth.generate_uptoken(policy)
    render json: { key: policy.key, token: token }
  end
end
