class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :account
  has_many :tickets, :foreign_key => "created_by_id"
  has_many :driver_tickets, :foreign_key => "driver_id", :class_name => "Ticket"

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :email, :scope => :account_id, :case_sensitive => false
  before_validation { |a| a.phone = phone.to_s.gsub(/[^0-9]/, "").to_s.squeeze(" ").strip }

  attr_accessor :updating_password

  def name
   full_name
  end

  def full_name
    (first_name + ' ' + last_name).titleize
  end

  def full_address
    (address + ' ' + address2 + ' ' + city + ' ' +  state + ' ' + zip_code).titleize
  end

  def should_validate_password?
      updating_password || new_record?
  end
  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    email = conditions.delete(:email)
    account_id = conditions.delete(:account_id)
    where(conditions).where(["lower(email) = :value", { :value => email.downcase }]).where("account_id = ?", account_id).first
  end
end
