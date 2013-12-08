class Lead < ActiveRecord::Base
  #has_many :comments, :as => :commenter

  before_validation { |lead| lead.zip = zip.to_s.gsub(/[^0-9]/, "").to_s }
  before_validation { |lead| lead.phone = phone.to_s.gsub(/[^0-9]/, "").to_s }

  def name
    full_name
  end

  def full_name
    first_name + ' ' + last_name
  end
end


