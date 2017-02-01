FactoryGirl.define do
  factory :post do
    title Faker::Hipster.sentence(3)
    body Faker::Hipster.sentence(50)
    area
  end

  factory :post_1, class: Post do
    title Faker::Hipster.sentence(2)
    body Faker::Hipster.sentence(50)
    area
  end

  factory :post_2, class: Post do
    title Faker::Hipster.sentence(4)
    body Faker::Hipster.sentence(50)
    area
  end
end
