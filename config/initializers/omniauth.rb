Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FB_CONSUMER_KEY'], ENV['FB_CONSUMER_SECRET']
end
