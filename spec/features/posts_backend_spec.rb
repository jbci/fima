require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature "posts backend" do
  before(:each) do
     Capybara.current_driver = :selenium
     @admin = FactoryGirl.create(:admin)
   end
   after(:all) do
     Capybara.use_default_driver
   end

  scenario "allow logged in admin to visit posts administration backend", js: true do
    login_as(@admin, :scope => :admin)
    visit '/backend/posts'
    # save_and_open_page
    expect(page).to have_content 'Initiatives'
  end

  scenario "exists a table of posts with 3 posts", js: true do
    post_1 = FactoryGirl.create(:post)
    post_2 = FactoryGirl.create(:post_1)
    post_3 = FactoryGirl.create(:post_2)

    login_as(@admin, :scope => :admin)
    visit '/backend/posts'
    # save_and_open_page
    expect(find('#posts_table')).to be
    # include header row
    expect(all("table#posts_table tr").count).to eq(4)
    # save_and_open_page
  end

  scenario "opens post popup to create a new post ", js: true do
    post_1 = FactoryGirl.create(:post)
    post_2 = FactoryGirl.create(:post_1)
    post_3 = FactoryGirl.create(:post_2)
    login_as(@admin, :scope => :admin)
    visit '/backend/posts'

    find('#new_post_link').click
    expect(find('#post-modal')).to be

    within("#post-modal") do
      fill_in 'Title', :with => 'Test Post Title'
      fill_in 'Body', :with => 'Test Post Body - Test Post Body'
      attach_file('Image', File.absolute_path('./app/assets/images/fima.jpg'))
      option = find_all('#post_comuna_dropdown option').last
      option.select_option
      find('#post_modal_button').click
    end

    wait_for_ajax
    find('#posts_table')
    within ('#posts_table') do
      expect(page.body).to have_content ('Test Post Title')
    end


    save_and_open_page
  end


end
