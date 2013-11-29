Fabricator(:account) do
 name { sequence(:name) { |i| Faker::Company.name + " #{i}" } }
 domain { sequence(:domain) { |i| "#{i}" + Faker::Internet.domain_name } }
 subdomain { sequence(:subdomain) { |i| Faker::HipsterIpsum.word.downcase + "#{i}" } }
end

