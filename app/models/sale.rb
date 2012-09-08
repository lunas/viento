class Sale < ActiveRecord::Base
  attr_accessible :actual_price, :client_id, :date, :piece_id_integer

  belongs_to :client, counter_cache: true
  belongs_to :piece,  counter_cache: true

  def price
    piece.try(:price)
  end
end
