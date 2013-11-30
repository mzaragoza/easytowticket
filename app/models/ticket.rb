class Ticket < ActiveRecord::Base
  belongs_to :account
  belongs_to :created_by, :class_name => "Admin"

  before_validation { |t| t.phone = phone.to_s.gsub(/[^0-9]/, "").to_s.squeeze(" ").strip }

  def millage
    if millage_finish && millage_start
      millage_finish - millage_start
    elsif millage_finish
      millage_finish
    elsif millage_start
      millage_start
    end
  end

  def servie
    if servie_time_finish && servie_time_start
      ((servie_time_finish - servie_time_start) / 1.hours).ceil
    elsif servie_time_finish
      servie_time_finish
    elsif servie_time_start
      servie_time_start
    end
  end
end

