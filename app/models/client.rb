class Client < ActiveRecord::Base
  attr_accessible :company, :country, :email, :first_name, :first_name2, :last_name, :last_name2, :notes,
                  :phone_home, :phone_mobile, :phone_work, :profession, :status, :mailing, :street,
                  :street2, :street_number, :title, :zip, :city, :roles_mask, :role,
                  :sales_count, :sales_total, :latest_sale_date
  attr_reader :mailing_info

  validates :last_name, presence: {message: 'Nachname darf nicht leer sein'}

  has_many :sales, order: "date DESC"
  has_many :pieces, through: :sales

  scope :with_sales_data, select('clients.*')
    .select('sum(s.actual_price) as sales_total, max(s.date) as latest_sale_date')
    .joins('left outer join sales s on clients.id = s.client_id')
    .group('clients.id')

  scope :for_export, with_sales_data.order("last_name, first_name, zip")

  def self.filter(search, status, role)
    if search.present?
      search_crit = "%#{search}%"
      clients = includes(:sales).where('last_name LIKE ? or first_name LIKE ? or city LIKE ?', search_crit, search_crit, search_crit)
    else
      clients = includes(:sales)
    end
    clients = clients.with_status(status) unless status.blank? || status == 'alle'
    clients = clients.with_role(role) unless role.blank? || role == 'alle'
    clients
  end

  def self.with_status(status)
    where('status = ?', status)
  end

  def self.to_csv( options = {} )
    CSV.generate(options) do |csv|
      cols = column_names.delete_if{ |col| col == 'roles_mask' }
      cols += %w{sales_total latest_sale_date}
      csv << (cols + ['role'])
      for_export.each do |client|
        row = client.attributes.values_at(*cols) << client.role
        csv << row
      end
    end
  end

  def self.greatest_sales_sums(limit)
    with_sales_data.order('sales_total DESC')
                   .limit(limit)
                   .inject([]) do |memo, client|
        memo << {name: client.name, total: client.sales_total}
        memo
    end
  end

  def address
    "#{street} #{street_number}".strip
  end

  def name_and_city
    nac = "#{self.name}, #{self.city}"
    nac.strip
  end

  def id_with_name_and_city
    {id: self.id, label: self.name_and_city}
  end

  def name
    n = "#{self.first_name} #{self.last_name}"
    n.strip
  end

  def sales_total
    self.sales.map(&:actual_price).inject(0, :+)
  end

  def sales_count
    self.sales.size
  end

  def latest_sale_date
    self.sales.first.try(:date) # works since sales are ordered by date DESC
  end

  def mailing_info
    mailing_type = self.mailing
    if mailing_type.present?
      if mailing_type=="email"
        self.email
      elsif %w[home work mobile].include? mailing_type
        self.send("phone_#{mailing_type}")
      else
        '-'
      end
    end
  end

  def phones
    ph = {}
    ph[:home]   = phone_home   if phone_home.present?
    ph[:work]   = phone_work   if phone_work.present?
    ph[:mobile] = phone_mobile if phone_mobile.present?
    ph
  end


  ## Roles

  def self.with_role(role)
    where("roles_mask & #{2**ROLES.index(role.to_s)} > 0" )
  end

  ROLES = %w[Kundinnen Interessentinnen Zeitschriften Andere Ehemalige Abschuss]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  def role
    self.roles.first
  end

  def role=(role)
    self.roles = [role]
  end

  STATES = %w[ja nein]  # "Versand"
  MAILINGS = %w[none home work mobile email]

end
