FactoryGirl.define do
  factory :user do
    f.email {Faker::Internet.email}
    f.password '12345678'
    f.password_confirmation '12345678'
    f.name {Faker::Name.name}
    f.avatar {Faker::Avatar.image}
  end
end
