namespace :db do
  namespace :migrate do

    desc 'Migrates clients'
    task :clients => :environment do
      require 'lib/tasks/legacy/legacy_client'

      puts 'Deleting clients...'
      Client.destroy_all
      puts 'Deleting pieces...'
      Piece.destroy_all
      puts 'Deleting sales...'
      Sale.destroy_all
      puts 'Existing data deleted.'

      puts 'Migrating clients'
      ActiveRecord::Base.record_timestamps = false

      LegacyClient.each do |lc|
        lc.migrate
      end

      LegacyPiece.each do |lc|
        lc.migrate
      end

      LegacySale.each do |lc|
        lc.migrate
      end

      ActiveRecord::Base.record_timestamps = true
    end

  end
end