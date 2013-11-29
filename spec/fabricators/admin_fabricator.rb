Fabricator(:admin) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.email }
  password 'password'
  address { Faker::AddressUS.street_address }
  address2 { Faker::AddressUS.secondary_address }
  city { Faker::AddressUS.secondary_address }
  state { Faker::AddressUS.state_abbr }
  zip_code { Faker::AddressUS.zip_code }
  country  'USA'
  occupation { Faker::Company.position }
  phone { Faker::PhoneNumber.short_phone_number }
  time_zone 'Eastern Time (US & Canada)'
  active  true
  after_build do |a|
    a.account ||= Account.last || Fabricate(:account)
  end
end
