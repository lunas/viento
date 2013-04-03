#https://devcenter.heroku.com/articles/rails-unicorn

worker_processes 3
timeout 30
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end

  #if defined?(Redis)
  #  Redis.current.quit
  #  Rails.logger.info('Disconnected from Redis')
  #end
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
  end

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    Rails.logger.info('Connected to ActiveRecord')
  end

  #if defined?(Redis)
  #  uri = URI.parse(ENV["REDISTOGO_URL"])
  #  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  #  Redis.current = REDIS
  #  Rails.logger.info('Connected to Redis')
  #end
end
