FactoryGirl.define do
  factory :branch do |f|

    f.name {Faker::Company.name}
    f.address {Faker::Address.street_address}
    f.phone {Faker::PhoneNumber.phone_number}
    f.schedule '9:00 - 9:00'
    f.city {Faker::Address.city}
    f.state {Faker::Address.state}
    f.country {Faker::Address.country}
    f.url {Faker::Internet.url}
    f.latitude {Faker::Address.latitude}
    f.longitude {Faker::Address.longitude}
    f.company_id 1
  end

end
