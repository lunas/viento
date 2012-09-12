class Piece < ActiveRecord::Base
  attr_accessible :collection, :color, :costs, :count_produced, :fabric, :name, :price, :size, :preis, :kosten



  def preis
    price
  end
  def preis=(value)
    price=value
  end
  def kosten
    costs
  end
  def kosten=(value)
    costs=value
  end


  has_many :sales
  has_many :clients, through: :sales, order: "sales.date, clients.last_name, clients.first_name"

  # Siehe auch die als private definierte Methode "validate" unten

  validates_numericality_of :size, :count_produced, :price, :costs,
                            :message => "darf nur Zahlen enthalten."

  validates_presence_of :collection, :name, :color, :fabric, #:groesse, :preis, :kosten, :anzahl,
                        :message => "darf nicht leer sein."

  validates_inclusion_of :size,
                         :in => [30, 32, 34, 36, 38, 40, 42, 44],
                         :message => "darf nicht leer sein und muss eine gerade Zahl zwischen 30 und 44 sein."

  validates_inclusion_of :count_produced,
                         :in => 0..200,
                         :message => "darf nicht leer sein und muss zwischen 0 und 200 liegen."

  validates_inclusion_of :price, :costs,
                         :in => 0..10000,
                         :message => "darf nicht leer sein und muss zwischen 0 und 10000 liegen."

  def self.collections
    Piece.order("collection").pluck(:collection).uniq
  end
  def self.names
    Piece.order("name").pluck(:name).uniq
  end
  def self.colors
    Piece.order("color").pluck(:color).uniq
  end
  def self.fabrics
    Piece.order("fabric").pluck(:fabric).uniq
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
              .joins('LEFT OUTER JOIN sales ON sales.piece_id = pieces.id')
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


  def count_stock
    self.count_produced - self.sales.size
  end

  def count_sold
    self.sales.size
  end

  #sql = "Select p.id, kollektion, name, farbe, material, groesse, preis, anzahl, kosten,
		#count_produced(s.id) as verkauft,
		#anzahl - count_produced(s.id) as restbestand
		#from pieces p left join sales s on p.id = s.piece_id "


  private
    # pr�ft, obs schon ein Teil mit genau gleichem Namen, Kollektion, Material, Farbe und Gr�sse gibt.
    # Wenn nichts gefunden wird, ist gut (true, sonst false)
  def validate
    p = Piece.find(:first, :conditions => ["name = ? AND kollektion = ? AND material = ? AND farbe = ? AND groesse = ?",
                                           self.name, self.kollektion, self.material, self.farbe, self.groesse])
    if p.nil? then
      return true
    elsif p.id == self.id then
      return true
    else
      errors.add_to_base("Es gibt schon ein Teil mit genau diesem Namen, Material, dieser Farbe, Gr&ouml;sse und Kollektion.")
      return false
    end
  end
end
