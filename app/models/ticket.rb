class Ticket < ActiveRecord::Base
  belongs_to :account
  belongs_to :created_by, :class_name => "Admin"

  before_validation { |t| t.phone = phone.to_s.gsub(/[^0-9]/, "").to_s.squeeze(" ").strip }

  def milleage
    if milleage_finish && milleage_start
      milleage_finish - milleage_start
    elsif milleage_finish
      milleage_finish
    elsif milleage_start
      milleage_start
    end
  end

  def service
    if service_time_finish && service_time_start
      ((service_time_finish - service_time_start) / 1.hours).ceil
    elsif service_time_finish
      service_time_finish
    elsif service_time_start
      service_time_start
    end
  end

  def extra
    if extra_truck_finish && extra_truck_start
      ((extra_truck_finish - extra_truck_start) / 1.hours).ceil
    elsif extra_truck_finish
      extra_truck_finish
    elsif extra_truck_start
      extra_truck_start
    end
  end
end

