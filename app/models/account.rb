class Account < ActiveRecord::Base
 # has_many :users
  has_many :admins
 # has_many :visitors
  accepts_nested_attributes_for :admins, :allow_destroy => true

  validates_uniqueness_of :name
  validates_presence_of :name

  scope :active, -> { where(:active => true) }

end

