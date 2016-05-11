uri = URI.parse(ENV["REDIS_PROVIDER"])
REDIS = Redis.new(:url => uri)