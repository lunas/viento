require 'rake'

Rake::Task.clear # necessary to avoid tasks being loaded several times in dev mode
Viento::Application.load_tasks

class Backup

  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    Rake::Task['db:backup'].reenable # in case you're going to invoke the same task second time.
    Rake::Task['db:backup'].invoke
  end

end