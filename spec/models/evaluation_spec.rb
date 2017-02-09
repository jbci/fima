require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  let(:evaluation) { FactoryGirl.create(:evaluation) }

  it "has a valid factory" do
    expect(evaluation).to be_valid
  end

  it "is not valid without an area" do
    evaluation.area = nil
    expect(evaluation).not_to be_valid
  end

  it "is not valid without an indicator" do
    evaluation.indicator = nil
    expect(evaluation).not_to be_valid
  end

  it "is not valid without a value" do
    evaluation.value = nil
    expect(evaluation).not_to be_valid
  end

end
