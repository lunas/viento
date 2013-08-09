require File.dirname(__FILE__) + '/legacy_base'

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
    }
  end

end