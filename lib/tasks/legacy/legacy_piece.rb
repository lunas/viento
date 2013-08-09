class LegacyPiece < LegacyBase
  set_table_name 'pieces'

  has_many  :sales, class_name: 'LegacySale'

  def map
    {
      name: self.name,
      collection: self.kollektion,
      color: self.farbe,
      fabric: self.material,
      size: self.groesse,
      count_produced: self.anzahl,
      price: self.preis,
      costs: self.kosten,
      created_at: self.created_at,
      updated_at: self.updated_at,
      sales_count: 0
    }
  end

end