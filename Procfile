redis: redis-server /usr/local/etc/redis.conf
web: bundle exec unicorn -c ./config/unicorn.rb -E production
worker: bundle exec sidekiq -e production

