class Sale < ActiveRecord::Base
  attr_accessible :actual_price, :client_id, :date, :piece_id, :client_name_and_city, :piece_info

  belongs_to :client, counter_cache: true
  belongs_to :piece,  counter_cache: true

  # checks whether actual_price OR self.piece.price is present!
  validates :client_id, :piece_id, :actual_price, presence: true
  validate :client_name_and_city_matches_client, :piece_info_matches_piece, :piece_available
  validate :date
  before_save :copy_attributes_if_empty

  # see http://stackoverflow.com/questions/9403577/rails-counter-cache-not-updating-correctly
  before_save :update_piece_counter_cache,  if: ->(sale) { !sale.new_record? && sale.piece_id_changed? }
  before_save :update_client_counter_cache, if: ->(sale) { !sale.new_record? && sale.client_id_changed? }

  # Sale.joins(:piece).where("pieces.name = ? and pieces.size = ?", 'Bastos', 34)
  def self.filter(criteria)
    sales = Sale.joins(:piece, :client)
    sales = sales.where("pieces.name" => criteria[:name] )          if criteria[:name] != 'total Anzahl'
    sales = sales.where( criteria[:attribute] => criteria[:value] ) if criteria[:value] != 'total Anzahl' && criteria.has_key?(:attribute)
    sales = sales.where( "pieces.collection" => criteria[:collection] ) if criteria.has_key?(:collection) && criteria[:collection] != 'total Anzahl'
    sales
  end

  def self.sales_for(params)
    if params[:client_id].present?
      Sale.joins(:piece, :client).where(client_id: params[:client_id])
    elsif params[:piece_id].present?
      Sale.joins(:piece, :client).where(piece_id: params[:piece_id])
    else
      Sale.joins(:piece, :client)
    end
  end

  def self.latest_date
    Sale.order("date DESC").limit(1).pluck(:date).first
  end

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

  def info
    "#{piece.name} fuer #{client.name}".strip
  end

  def copy_attributes_if_empty
    self.actual_price = price if self.read_attribute(:actual_price).blank?
    self.date = self.created_at if self.read_attribute(:date).blank?
    self.date = Date.today if self.date.blank?
  end

  def update_piece_counter_cache
    Piece.decrement_counter(:sales_count, self.piece_id_was)
    Piece.increment_counter(:sales_count, self.piece_id)
  end

  def update_client_counter_cache
    Client.decrement_counter(:sales_count, self.client_id_was)
    Client.increment_counter(:sales_count, self.client_id)
  end

  def client_name_and_city_matches_client
    return if @tmp_client_name_and_city.blank? # when created not by controller
    if @tmp_client_name_and_city != self.client.try(:name_and_city)
      errors.add(:client_name_and_city, I18n.t('sales.errors.choose_client_from_list') )
    end
  end

  def piece_info_matches_piece
    return if @tmp_piece_info.blank? # when created not by controller
    if @tmp_piece_info != self.piece.try(:info)
      errors.add(:piece_info, I18n.t('sales.errors.choose_piece_form_list') )
    end
  end

  def piece_available
    return if piece.nil? || piece_unchanged?
    if piece.try(:sold_out)
      errors.add(:piece_info, "Dieses Teil ist ausverkauf.")
    end
  end

  def piece_unchanged?
    ! piece_id_changed?
  end

end
