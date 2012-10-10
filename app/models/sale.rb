class Sale < ActiveRecord::Base
  attr_accessible :actual_price, :client_id, :date, :piece_id

  belongs_to :client, counter_cache: true
  belongs_to :piece,  counter_cache: true

  # checks whether actual_price OR self.piece.price is present!
  validates :actual_price, presence: true

  before_save :copy_actual_price_if_empty

  def price
    piece.try(:price)
  end

  def actual_price
    p = read_attribute(:actual_price)
    p.present? ? p : self.price
  end

  def date
    d = read_attribute(:date)
    d.present? ? d : self.created_at.to_date
  end

  def copy_actual_price_if_empty
    self.actual_price = price if self.read_attribute(:actual_price).blank?
  end
end
