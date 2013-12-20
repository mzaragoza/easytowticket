Fabricator(:account) do
 name          { sequence(:name) { |i| Faker::Company.name + " #{i}" } }
 ticket_prefix { (0...4).map { ('a'..'z').to_a[rand(26)] }.join }
 domain        { sequence(:domain) { |i| "#{i}" + Faker::Internet.domain_name } }
 subdomain     { sequence(:subdomain) { |i| Faker::HipsterIpsum.word.downcase + "#{i}" } }
end

