class LegacyClient < LegacyBase
  set_table_name 'clients'

  has_many  :sales, class_name: 'LegacySale'
  belongs_to :role, class_name: 'LegacyRole'
  belongs_to :state, class_name: 'LegacyState'

  def map
    {
      company: self.firma,
      country: self.land,
      email:   nil,
      title: self.anrede,
      first_name: self.vorname,
      first_name2: self.vorname2,
      last_name: self.nachname,
      last_name2: self.nachname2,
      notes: self.bemerkungen,
      phone_home: self.tel_priv,
      phone_mobile: self.tel_mob,
      phone_work: self.tel_job,
      profession: self.beruf,
      status: self.state_id == 1 ? 'ja' : 'nein',
      roles_mask: role_num,
      mailing: nil,
      street: self.strasse,
      street2: self.adresse2,
      street_number: self.hausnummer,
      zip: self.plz,
      city: self.ort,
      roles_mask: [self.role.rolle],
      sales_count: 0,
      created_at: self.created_at,
      updated_at: self.updated_at
    }
  end

  def role_num
    i = Client::ROLES.index self.role.rolle
    raise "Invalid legacy role: #{self.role.rolle}." if i.nil?
    2**i
  end
end