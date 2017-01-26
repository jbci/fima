require 'rails_helper'

RSpec.describe Section, type: :model do

  let(:section) { FactoryGirl.create(:section) }

  it "has a valid factory" do
    expect(section).to be_valid
  end

  it "is not valid without a title" do
    section.title = nil
    expect(section).not_to be_valid
  end

  it "is not valid without a description" do
    section.description = nil
    expect(section).not_to be_valid
  end

  it "can have indicators" do
    indicator_1 = FactoryGirl.create(:indicator)
    indicator_2 = FactoryGirl.create(:indicator)
    section.indicators << indicator_1
    section.indicators << indicator_2
    expect(section.indicators).to include(indicator_1)
    expect(section.indicators).to include(indicator_2)
  end

  it "is not valid without a ratings reference" do
    section.rating = nil
    expect(section).not_to be_valid
  end

end
