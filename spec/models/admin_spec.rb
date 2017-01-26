require 'rails_helper'

RSpec.describe Admin, type: :model do

  let(:admin) { FactoryGirl.create(:admin) }

  it "has a valid factory" do
    expect(admin).to be_valid
  end
end
