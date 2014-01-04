Fabricator(:ticket) do
  location_of_viecle                       { Faker::AddressUS.secondary_address + ' ' + Faker::AddressUS.state_abbr + ' ' + Faker::AddressUS.zip_code   }
  name                                     { Faker::Name.first_name + ' ' + Faker::Name.last_name }
  phone                                    { Faker::PhoneNumber.short_phone_number  }
  address                                  {  Faker::AddressUS.street_address + ' ' + Faker::AddressUS.secondary_address + ' ' + Faker::AddressUS.secondary_address + ' ' + Faker::AddressUS.state_abbr + ' ' + Faker::AddressUS.zip_code }
  zip                                      { Faker::AddressUS.zip_code }
  milleage_finish                          { rand(1000000)  }
  milleage_start                           { rand(1000000)  }
  service_time_finish                      { Time.new + 1.hour }
  service_time_start                       { Time.new }
  extra_truck_finish                      {  }
  extra_truck_start                       {  }
  car_year                                 { Date.today.year - rand(40) }
  car_make                                 { Faker::Lorem.words(2).join(' ') }
  car_model                                { Faker::Lorem.words(2).join(' ') }
  car_color                                { Faker::Lorem.words(2).join(' ') }
  tag_number                               { (0...4).map { (65 + rand(26)).chr }.join + '-' + (0...4).map { (65 + rand(26)).chr }.join}
  state                                    { Faker::AddressUS.state_abbr }
  license_number                           { ['SSSS-FFF-YY-DDD-N', 'F25592150094', 'SSSS-FFF-YY-DDD-N', 'F255-921-50-094-0'].sample }
  vin_number                               { ['VIN2HNYD284X7H536884', 'VIN19UUA8F58CA017192', 'VINJH4CU26619C029283', 'VIN19UUA66227A026955'].sample }
  sling                                    { [true, false].sample }
  hoist_tow                                { [true, false].sample }
  wheel_lift                               { [true, false].sample }
  flad_bed                                 { [true, false].sample }
  start                                    { [true, false].sample }
  lock_out                                 { [true, false].sample }
  flat_tire                                { [true, false].sample }
  out_of_gas                               { [true, false].sample }
  wreck                                    { [true, false].sample }
  recovery                                 { [true, false].sample }
  other                                    { Faker::Lorem.words(2).join(' ') }
  special_equipment_single_line_winching   { [true, false].sample}
  special_equipment_dual_line_winching     { [true, false].sample}
  special_equipment_snatch_blocks          { [true, false].sample}
  special_equipment_scotch_blocks          { [true, false].sample}
  special_equipment_dolly                  { [true, false].sample}
  special_equipment_other                  { Faker::Lorem.words(2).join(' ') }
  operators_comments                       { Faker::Lorem.words(20).join(' ') }
  status                                   { ['inshop'].sample }
  status                                   { ['inshop'].sample }
  after_build do |t|
    t.account      ||= Account.last || Fabricate(:account)
    t.requested_by ||= t.account.admins.last || Fabricate(:admin, :account_id => t.account)
    t.created_by   ||= t.account.admins.last || Fabricate(:admin, :account_id => t.account)
    t.driver       ||= t.account.admins.where(:is_driver => true).last || Fabricate(:admin, :account_id => t.account, :is_driver => true)
    #t.truck       ||= t.account.truck.last || Fabricate(:truck, :account_id => t.account)
  end
end

