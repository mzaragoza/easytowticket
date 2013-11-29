class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :account

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :email, :scope => :account_id, :case_sensitive => false

  def name
   full_name
  end

  def full_name
    (first_name + ' ' + last_name).titleize
  end

  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    email = conditions.delete(:email)
    account_id = conditions.delete(:account_id)
    where(conditions).where(["lower(email) = :value", { :value => email.downcase }]).where("account_id = ?", account_id).first
  end
end
