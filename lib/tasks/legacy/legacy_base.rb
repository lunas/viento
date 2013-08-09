class LegacyBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :legacy

  class << self; attr_accessor :num_migrated; end
  def inc_counter
    self.class.num_migrated ||= 0
    self.class.num_migrated += 1
  end

  def migrate
    klass = self.class.to_s.gsub(/Legacy/,'::').constantize
    klass.attr_protected
    @new_record = klass.new(map)
    @new_record[:id] = self.id
    @new_record[:created_at] = self.created_on || Time.now
    @new_record[:updated_at] = self.updated_on || Time.now
    begin
      @new_record.save!
      inc_counter
      print '.'
    rescue Exception => e
      # this is mostly for ActiveRecord Validation errors - if the validation fails, it
      # typically means you need to adjust the validations or the model you're migrating
      # your legacy data into. this is especially useful information when you're migrating
      # user data established with one auth library to a code base which uses another.
      msg = "error saving #{@new_record.class} #{@new_record.id}!"
      logger.error msg
      logger.error e.inspect
      puts msg
      puts e.inspect
    end
  end

end