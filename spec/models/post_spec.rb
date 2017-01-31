require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryGirl.create(:post) }

  it "has a valid factory" do
    expect(post).to be_valid
  end

  it "is not valid without a title" do
    post.title = nil
    expect(post).not_to be_valid
  end

  it "is not valid without a body" do
    post.body = nil
    expect(post).not_to be_valid
  end

  it "is not valid without an area" do
    post.area = nil
    expect(post).not_to be_valid
  end

  it "can have an image" do
    post.image = File.new("app/assets/images/fima.jpg")
    expect(post).to be_valid
  end

end
