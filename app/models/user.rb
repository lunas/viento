class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable #, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :roles

  validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates :roles_mask, presence: true

  before_destroy do |user|
    if user.role? :admin
      errors[:base] << I18n.t('users.errors.cant_delete_admin')
      false
    else
      true
    end
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end


  ## Roles

  def self.with_role(role)
    where("roles_mask & #{2**ROLES.index(role.to_s)} > 0" )
  end

  ROLES = %w[boss worker admin]

  def roles=(roles)
    roles.collect!{ |r| r.to_s }
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(candidate_roles)
    if candidate_roles.is_a? Array
      candidate_roles.collect!{ |r| r.to_s }
      ! (roles & candidate_roles).empty?
    else
      roles.include? candidate_roles.to_s
    end
  end

end
