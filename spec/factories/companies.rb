FactoryGirl.define do
  factory :company do
    f.name {Faker::Company.name}
    f.email {Faker::Internet.email}
    f.password '12345678'
    f.password_confirmation '12345678'
    f.phone {Faker::PhoneNumber.phone_number}
    f.description 'Head Company'
    f.url {Faker::Internet.url}
  end
end
