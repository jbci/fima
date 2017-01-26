require 'rails_helper'

RSpec.describe Area, type: :model do

    let(:area) { FactoryGirl.create(:area) }

    it "has a valid factory" do
      expect(area).to be_valid
    end

    it "is not valid without a name" do
      area.name = nil
      expect(area).not_to be_valid
    end

    it "is not valid without a area_level" do
      area.area_level = nil
      expect(area).not_to be_valid
    end

end
