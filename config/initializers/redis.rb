redis_config = YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]

$redis = Redis.new(host: redis_config['host'], port: redis_config['port'])

# redis object redis设置
Redis::Objects.redis = $redis

# Sidekiq初始化
sidekiq_url = "redis://#{redis_config['host']}:#{redis_config['port']}/0"
Sidekiq.configure_server do |config|
  config.redis = { namespace: 'sidekiq', url: sidekiq_url }
end
Sidekiq.configure_client do |config|
  config.redis = { namespace: 'sidekiq', url: sidekiq_url }
end