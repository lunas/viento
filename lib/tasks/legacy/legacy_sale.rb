class LegacySale < LegacyBase
  set_table_name 'sales'

  belongs_to :client, class_name: 'LegacyClient'
  belongs_to :piece,  class_name: 'LegacyPiece'

  def map
    {
      client_id: self.client_id,
      piece_id:  self.piece_id,
      date:      self.datum,
      actual_price: self.verkaufspreis,
      created_at: self.created_at,
      updated_at: self.updated_at
    }
  end

end