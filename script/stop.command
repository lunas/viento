kill $(ps aux | grep -E 'redis|sidekiq|unicorn' | grep -v grep | awk '{print $2}')
nginx -s stop