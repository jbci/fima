FactoryGirl.define do
  factory :area_level do
    # name Faker::Hipster.word
     sequence(:name) { |n| "Caspian Star #{n}" }
  end
end
