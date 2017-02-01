require 'rails_helper'

RSpec.describe AreaLevel, type: :model do
  let(:area_level) { FactoryGirl.create(:area_level) }

  it "has a valid factory" do
    expect(area_level).to be_valid
  end
end
