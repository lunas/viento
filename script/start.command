#!/bin/sh

# first kill existing processes of redis/sidekiq/unicorn, then alson nginx:
kill $(ps aux | grep -E 'redis|sidekiq|unicorn' | grep -v grep | awk '{print $2}')
nginx -s stop

# now start them again
nginx

cd ~/workspaces/viento
foreman start
