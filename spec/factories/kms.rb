FactoryGirl.define do
  factory :km do |f|

    f.sinparun_kms {Faker::Number.number(2)}
    f.total_kms {Faker::Number.number(2)}
    f.nike_last_total_kms {Faker::Number.number(2)}
    f.level 1
    f.races 1
    f.user_id 1
  end

end
