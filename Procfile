redis: redis-server /usr/local/etc/redis.conf
web: bundle exec puma -e production --config config/puma.rb 
worker: bundle exec sidekiq -e production -C config/sidekiq.yml

