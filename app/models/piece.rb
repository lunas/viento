class Piece < ActiveRecord::Base
  attr_accessible :collection, :color, :costs, :count, :fabric, :name, :price, :size

  has_and_belongs_to_many :clients, :join_table => "sales", :order => "sales.datum, clients.nachname, clients.vorname"
  has_many :sales

  def self.collections
    Piece.order("collection").pluck(:collection).uniq
  end

  def self.latest_collection
    order('collection desc').limit(1).pluck(:collection).first
  end


  #sql = "Select p.id, kollektion, name, farbe, material, groesse, preis, anzahl, kosten,
		#count(s.id) as verkauft,
		#anzahl - count(s.id) as restbestand
		#from pieces p left join sales s on p.id = s.piece_id "

end
