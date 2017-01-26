require 'rails_helper'

RSpec.describe Indicator, type: :model do

    let(:indicator) { FactoryGirl.create(:indicator) }

    it "has a valid factory" do
      expect(indicator).to be_valid
    end

    it "is not valid without a title" do
      indicator.title = nil
      expect(indicator).not_to be_valid
    end

    it "is not valid without a description" do
      indicator.description = nil
      expect(indicator).not_to be_valid
    end

    it "is not valid without a section reference" do
      indicator.section = nil
      expect(indicator).not_to be_valid
    end
end
