require File.dirname(__FILE__) + '/legacy_base'

class LegacyRole < LegacyBase
  set_table_name 'roles'

  def map
    {
        name: self.rolle,
        order:  self.reihenfolge,
    }
  end

end