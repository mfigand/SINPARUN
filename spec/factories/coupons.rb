FactoryGirl.define do
  factory :coupon do |f|

    f.code {Faker::Number.number(8)}
    f.kms_cost {Faker::Number.number(2)}
    f.redeemed 'pending'
    f.user_id 1
    f.employee_id 1
    f.reward_id 1
  end

end
