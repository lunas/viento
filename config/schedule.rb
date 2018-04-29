# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# set :output, File.join( File.dirname(__FILE__) , '../../log/cron.log')
set :output, '/Users/anjaboije/Sites/viento/log/cron.log'
every :tuesday, at: '14:48' do
  rake 'db:backup'
end
