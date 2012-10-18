class Sale < ActiveRecord::Base
  attr_accessible :actual_price, :client_id, :date, :piece_id, :client_name_and_city, :piece_info

  belongs_to :client, counter_cache: true
  belongs_to :piece,  counter_cache: true

  # checks whether actual_price OR self.piece.price is present!
  validates :client_id, :piece_id, :actual_price, presence: true
  validate :client_name_and_city_matches_client, :piece_info_matches_piece
  before_save :copy_attributes_if_empty

  def price
    piece.try(:price)
  end

  def actual_price
    p = read_attribute(:actual_price)
    p.present? ? p : self.price
  end

  def date
    d = read_attribute(:date)
    d.present? ? d : self.created_at.try(:to_date) || Date.today
  end

  def client_name_and_city
    client.try(:name_and_city)
  end

  def client_name_and_city=(value)
    @tmp_client_name_and_city = value
  end

  def piece_info
    piece.try(:info)
  end

  def piece_info=(value)
    @tmp_piece_info = value
  end

  def copy_attributes_if_empty
    self.actual_price = price if self.read_attribute(:actual_price).blank?
    self.date = self.created_at if self.read_attribute(:date).blank?
    self.date = Date.today if self.date.blank?
  end

  def client_name_and_city_matches_client
    return if @tmp_client_name_and_city.blank? # when created not by controller
    if @tmp_client_name_and_city != self.client.try(:name_and_city)
      errors.add(:client_name_and_city, "Bitte eine Kundin aus der Liste auswaehlen")
    end
  end

  def piece_info_matches_piece
    return if @tmp_piece_info.blank? # when created not by controller
    if @tmp_piece_info != self.piece.try(:info)
      errors.add(:piece_info, "Bitte ein Teil aus der Liste auswaehlen")
    end
  end
end
