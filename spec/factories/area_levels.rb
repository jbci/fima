FactoryGirl.define do

  factory :area_level do
    # name Faker::Hipster.word
     sequence(:name) { |n| "level_0_#{n}" }
  end

  factory :area_level_1, class: AreaLevel do
    # name Faker::Hipster.word
     sequence(:name) { |n| "level_1_#{n}" }
  end

  factory :area_level_2, class: AreaLevel do
    # name Faker::Hipster.word
     sequence(:name) { |n| "level_2_#{n}" }
  end
end
