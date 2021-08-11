ApiWarden.configure do |config|
  config.redis = { url: Settings[:redis_url] }
end

ApiWarden.ward_by(
  'users',
  expire_time_for_access_token: 7.days.seconds,
  expire_time_for_refresh_token: 14.days.seconds,
  load_owner: proc { |id| User.find_by(id: id) }
)
