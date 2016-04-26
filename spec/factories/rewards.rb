FactoryGirl.define do
  factory :reward do |f|

    f.name 'Beer'
    f.kms_cost {Faker::Number.number(2)}
    f.code {Faker::Number.number(8)}
    f.description {Faker::Beer.name}
    f.valid_from Date.today
    f.valid_through {Faker::Date.between(Date.today, 1.month.from_now)}
    f.available_units {Faker::Number.number(1)}
    f.reserved_units {Faker::Number.number(1)}
    f.charged_units {Faker::Number.number(1)}
    f.company_id 1
    f.branch_id 1
    f.image {Faker::Avatar.image}
  end

end
