class Piece < ActiveRecord::Base
  attr_accessible :collection, :color, :costs, :count_produced, :fabric, :name, :price, :size

  has_many :sales
  has_many :clients, through: :sales, order: "sales.date, clients.last_name, clients.first_name"

  def self.collections
    Piece.order("collection").pluck(:collection).uniq
  end

  def self.latest_collection
    order('collection desc').limit(1).pluck(:collection).first
  end

  def self.with_collection(collection)
    where('collection = ?', collection)
  end

  def self.with_stock_and_sold
  #scope :with_stock_and_sold,
        select('pieces.id, collection, color, costs, count_produced, fabric, name, price, size')
              .select('count(sales.id) as sold')
              .select('count_produced - count(sales.id) as stock')
              .joins('pieces LEFT OUTER JOIN sales ON sales.piece_id = pieces.id')
              .group('pieces.id')
  end

  def self.filter(search, collection)
    if search.present?
      pieces = with_stock_and_sold.where('name LIKE ?', "%#{search}%")
    else
      pieces = with_stock_and_sold
    end
    pieces = pieces.with_collection(collection) unless collection.blank? || collection == 'alle'
    pieces
  end


  def stock
    self.count_produced - self.sales.size
  end

  def sold
    self.sales.size
  end

  #sql = "Select p.id, kollektion, name, farbe, material, groesse, preis, anzahl, kosten,
		#count_produced(s.id) as verkauft,
		#anzahl - count_produced(s.id) as restbestand
		#from pieces p left join sales s on p.id = s.piece_id "

end
