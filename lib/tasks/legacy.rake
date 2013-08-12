namespace :db do
  namespace :migrate do

    desc 'Creates 2 users, then migrates clients, pieces, and sales. Deletes all existing data in new database!'
    task :legacy_viento => :environment do
      require File.dirname(__FILE__) + '/legacy/legacy_client'
      require File.dirname(__FILE__) + '/legacy/legacy_piece'
      require File.dirname(__FILE__) + '/legacy/legacy_sale'

      puts 'Going to delete ALL clients, pieces, and sales. Are you sure? (y/n)'
      input = STDIN.gets.strip
      if input != 'y'
        puts 'bye'

      else

        puts 'Deleting clients...'
        Client.destroy_all
        puts 'Deleting pieces...'
        Piece.destroy_all
        puts 'Deleting sales...'
        Sale.destroy_all
        puts 'Existing data deleted.'

        ActiveRecord::Base.record_timestamps = false

        puts "Migrating clients"
        LegacyClient.all.each { |lc| lc.migrate }

        puts "\nMigrating pieces"
        LegacyPiece.all.each { |lc| lc.migrate }

        puts "\nMigrating sales"
        LegacySale.all.each { |lc| lc.migrate }

        ActiveRecord::Base.record_timestamps = true

        puts "\nCopied:"
        puts "- #{LegacyClient.num_migrated} clients"
        puts "- #{LegacyPiece.num_migrated} pieces"
        puts "- #{LegacySale.num_migrated} sales"

      end
    end
  end
end