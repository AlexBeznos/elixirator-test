FactoryGirl.define do
  factory :user do
    role { User.roles.keys.sample }
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    age { rand(18..70) }
    password 'demopass'
  end

  factory :admin, parent: :user do
    role 'admin'
    age { rand(18..45) }
  end

  factory :employee, parent: :user do
    role 'employee'
    age { rand(35..70) }
  end

  factory :manager, parent: :employee do
    role 'management'
  end
end
