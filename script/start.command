#!/bin/sh

# first kill existing processes of redis/sidekiq/unicorn, then alson nginx:
kill $(ps aux | grep -E 'redis|sidekiq|puma' | awk '{print $2}')

brew services restart nginx

cd ~/Sites/viento
foreman start
