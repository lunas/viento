class Client < ActiveRecord::Base
  attr_accessible :company, :country, :email, :first_name, :first_name2, :last_name, :last_name2, :notes,
                  :phone_home, :phone_mobile, :phone_work, :profession, :status, :street,
                  :street2, :street_number, :title, :zip, :roles_mask

  def self.filter(search, status, role)
    if search.present?
      search_crit = "%#{search}%"
      clients = where('last_name LIKE ? or first_name LIKE ? or city LIKE ?', search_crit, search_crit, search_crit)
    else
      clients = scoped
    end
    clients = clients.with_status(status) unless status.blank?
    clients = clients.with_role(role) unless role.blank?
    clients
  end

  def self.with_status(status)
    where('status = ?', status)
  end

  def address
    "#{street} #{street_number}".strip
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

  STATES = %w[aktiv passiv]

end
