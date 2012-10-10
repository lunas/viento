class Client < ActiveRecord::Base
  attr_accessible :company, :country, :email, :first_name, :first_name2, :last_name, :last_name2, :notes,
                  :phone_home, :phone_mobile, :phone_work, :profession, :status, :street,
                  :street2, :street_number, :title, :zip, :city, :roles_mask, :role

  validates :last_name, presence: {message: 'Nachname darf nicht leer sein'}

  has_many :sales, order: "date DESC"
  has_many :pieces, through: :sales

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

  def address
    "#{street} #{street_number}".strip
  end

  def name_and_city
    nac = "#{self.name}, #{self.city}"
    nac.strip
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

  STATES = %w[aktiv passiv]

end
