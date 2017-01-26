require 'rails_helper'

RSpec.describe Rating, type: :model do

  let(:rating) { FactoryGirl.create(:rating) }

  it "has a valid factory" do
    expect(rating).to be_valid
  end

  it "is not valid without a title" do
    rating.title = nil
    expect(rating).not_to be_valid
  end

  it "is not valid without a description" do
    rating.description = nil
    expect(rating).not_to be_valid
  end

  it "can have sections" do
    section_1 = FactoryGirl.create(:section)
    section_2 = FactoryGirl.create(:section)
    rating.sections << section_1
    rating.sections << section_2
    expect(rating.sections).to include(section_1)
    expect(rating.sections).to include(section_2)
  end
end
