FactoryGirl.define do
  factory :employee do
    f.email {Faker::Internet.email}
    f.name {Faker::Name.name}
    f.password '12345678'
    f.password_confirmation '12345678'
    f.phone {Faker::PhoneNumber.cell_phone}
    f.branch_id 1
  end
end
