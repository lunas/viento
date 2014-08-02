namespace :db do desc "Update Client and Piece sales_count cache counter"
  task :update_cache_count => [:environment] do

    [Client, Piece].each do |model|
      model.reset_column_information
      model.all.each do |m|
        model.reset_counters m.id, :sales
        puts "Set #{model.to_s}.sales_count to #{m.sales.length}"
      end
    end

  end
end

# Sql query to test whether sales_count cache is correct:
# select p.id, sales_count, count(s.id) from pieces p left join sales s on p.id = s.piece_id group by p.id having p.sales_count = count(s.id);