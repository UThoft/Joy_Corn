class SignedUrlsController < ApplicationController
  def index
    s3 = AWS::S3::new

    # try to check if every time call the following function. will need
    # to connect to the Amazon Server.
    bucket = s3.buckets['wecorn']
    signed_data = bucket.presigned_post(acl: 'public-read', success_action_status: '200')
    render json: signed_data.fields.merge(key: "uploads/#{SecureRandom.uuid}/#{params[:doc][:title]}")
  end
end