class Sale < ActiveRecord::Base
  attr_accessible :actual_price, :client_id, :date, :piece_id

  belongs_to :client, counter_cache: true
  belongs_to :piece,  counter_cache: true

  def price
    piece.try(:price)
  end

  def actual_price
    p = read_attribute(:actual_price)
    p.present? ? p : self.price
  end
end
