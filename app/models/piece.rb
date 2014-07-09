class Piece < ActiveRecord::Base

  require 'goldmine'

  attr_accessible :collection, :color, :costs, :count_produced, :fabric, :name, :price, :size, :preis, :kosten, :piece_info, :notes

  has_many :sales
  has_many :clients, through: :sales, order: "sales.date, clients.last_name, clients.first_name"

  # Siehe auch die als private definierte Methode "validate" unten

  validates_numericality_of :size, :count_produced, :price, :costs,
                            :message => "darf nur Zahlen enthalten.",
                            :allow_nil => true

  validates_presence_of :collection, :name, :color, :fabric, :size, :preis,
                        :message => "darf nicht leer sein."

  validates_inclusion_of :size,
                         :in => [30, 32, 34, 36, 38, 40, 42, 44],
                         :message => "darf nicht leer sein und muss eine gerade Zahl zwischen 30 und 44 sein."

  validates_inclusion_of :count_produced,
                         :in => 0..200,
                         :message => "darf nicht leer sein und muss zwischen 0 und 200 liegen."

  validates_inclusion_of :price, :costs,
                         :in => 0..10000,
                         :message => "darf nicht leer sein und muss zwischen 0 und 10000 liegen.",
                         :allow_nil => true

  validate :check_for_double

  def self.collections
    Piece.order("collection DESC").pluck(:collection).uniq
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
    order('collection DESC').limit(1).pluck(:collection).first
  end

  def self.with_collection(collection)
    collection.nil? ? scoped : where('collection = ?', collection)
  end

  def self.period(from, to)
    #Piece.select("pieces.id, name, collection, max(date) as last_sale, min(date) as first_sale, count(pieces.id) as sales_count")
    #.group("pieces.id").joins(:sales).having("min(date) >= ? and max(date) <= ?", from, to)

    Piece.select("pieces.id, name, collection, count(pieces.id) as sales_count, sum(pieces.count_produced)/count(pieces.id) as count_produced")
      .joins(:sales)
      .where("sales.date" => (from..to) )
      .group("pieces.id")

    #Piece.select("pieces.id, name, collection, count(pieces.id) as sales_count")
    #     .joins(:sales)
    #     .where("sales.date" => (from..to))
    #Piece.joins(:sales).where("sales.date" => (from..to))
  end

  # TODO rspec
  def self.with_stock_and_sold
    select('pieces.id, collection, color, costs, count_produced, fabric, name, price, size')
      .select('count(sales.id) as sold')
      .select('count_produced - count(sales.id) as stock')
      .joins('LEFT OUTER JOIN sales ON sales.piece_id = pieces.id')
      .group('pieces.id')
  end

  # TODO rspec
  def self.filter(search, collection)
    if search.present?
      search = "%#{search}%"
      pieces = with_stock_and_sold.where('name LIKE ? OR color LIKE ? OR fabric LIKE ?', search, search, search)
    else
      pieces = with_stock_and_sold
    end
    pieces = pieces.with_collection(collection) unless collection.blank? || collection == 'alle'
    pieces
  end

  def self.revenue_by_collection
    sql = 'SELECT p.collection, sum(p.count_produced) as total_produced,
           sum(s.sales_count) as total_sold,
           sum(s.revenue) as total_revenue,
           ROUND(sum(s.sales_count)/sum(p.count_produced) * 100, 0) as percent_sold
           from pieces as p LEFT JOIN (
             SELECT piece_id, count(id) as sales_count, sum(actual_price) as revenue
             FROM sales
             GROUP by piece_id
           ) as s on p.id = s.piece_id
           GROUP by collection
           ORDER by collection DESC;'
    find_by_sql(sql);
  end

  def sold_out
    count_stock <= 0
  end

  def count_stock
    self.count_produced - self.sales.size
  end

  def count_sold
    self.sales.size
  end

  def preis
    self.price
  end
  def preis=(value)
    self.price=value
  end
  def kosten
    self.costs
  end
  def kosten=(value)
    self.costs=value
  end

  # Returns sum of actual_price of its sales.
  def revenue
    self.sales.inject(0){ |total, sale| total += sale.actual_price }
  end

  def info
    "#{self.collection} - #{self.name}: #{self.fabric}, #{self.size}, #{self.color}"
  end

  def info_name_first
    " #{self.name} (#{self.collection}): #{self.fabric}, #{self.size}, #{self.color}"
  end

  def id_with_info_and_price
    {id: self.id, label: self.info, price: self.price}
  end

  def self.table_by_size(collection = nil)
    with_collection(collection).table_by(:size, "Groesse")
  end

  def self.table_by_color(collection = nil)
    with_collection(collection).table_by(:color, "Color")
  end

  def self.table_by_fabric(collection = nil)
    with_collection(collection).table_by(:fabric, "Material")
  end

  def self.table_by_collection(from, to)
    period(from, to).table_by(:collection, "Kollektion")
  end

  def check_for_double
    p = Piece.where(name: self.name, collection: self.collection,
                    color: self.color, fabric: self.fabric, size: self.size).first
    if p.nil?
      true
    elsif p.id = self.id
      true
    else
      errors[:base] << I18n.translate('activerecord.errors.messages.duplicate_piece')
    end
  end

  private

  def self.table_by(pivot_column, pivot_column_name)

    cell_block = ->(pieces) {
      pieces.inject([0,0]) do |result, piece|
        result[0] += piece.sales_count.to_i
        result[1] += piece.count_stock.to_i
        result
      end
    }
    total_block = ->(items) {
      items.inject([0,0]) do |result, item|
        unless item.nil?
          result[0] += item[0]
          result[1] += item[1]
        end
        result
      end
    }

    Piece.all
      .pivot(pivot_column_name) {|p| p.send(pivot_column) }  # group by pivot_column, e.g. 'color'
      .pivot("Name") {|p| p.name }                           # group each color by piece name
      .to_2d("", {cell: cell_block, row_total: total_block, col_total: total_block} )
  end

end
