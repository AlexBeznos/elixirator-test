FactoryGirl.define do
  factory :product do
    title { Faker::Commerce.product_name }
    articul { Faker::Number.hexadecimal(12) }
    price { Faker::Commerce.price }
    sale { rand(2).odd? ? rand(0.0..0.3).round(2) : 0 }
    association :updated_by, factory: :user
  end
end
