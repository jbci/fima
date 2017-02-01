require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature "areas backend" do
  before(:each) do
     Capybara.current_driver = :selenium
     @admin = FactoryGirl.create(:admin)
   end
   after(:all) do
     Capybara.use_default_driver
   end

  scenario "allow logged in admin to visit areas administration backend", js: true do
    login_as(@admin, :scope => :admin)
    visit '/backend/areas'
    # save_and_open_page
    expect(page).to have_content 'Areas'
  end

  scenario "exists a table of area_levels", js: true do
    area_level_1 = FactoryGirl.create(:area_level)
    area_level_2 = FactoryGirl.create(:area_level_1)
    area_level_3 = FactoryGirl.create(:area_level_2)

    login_as(@admin, :scope => :admin)
    visit '/backend/areas'
    # save_and_open_page
    expect(find('#area_levels_table')).to be
    # include header row
    # expect(all("table#area_levels_table tr").count).to eq(4)
    save_and_open_page
  end
  #
  # scenario "opens area popup to create a new area ", js: true do
  #   area_1 = FactoryGirl.create(:area)
  #   area_2 = FactoryGirl.create(:area_1)
  #   area_3 = FactoryGirl.create(:area_2)
  #   login_as(@admin, :scope => :admin)
  #   visit '/backend/areas'
  #
  #   find('#new_area_link').click
  #   expect(find('#area-modal')).to be
  #
  #   within("#area-modal") do
  #     fill_in 'Title', :with => 'Test Post Title'
  #     fill_in 'Body', :with => 'Test Post Body - Test Post Body'
  #     attach_file('Image', File.absolute_path('./app/assets/images/fima.jpg'))
  #     option = find_all('#area_comuna_dropdown option').last
  #     option.select_option
  #     find('#area_modal_button').click
  #   end
  #
  #   wait_for_ajax
  #   find('#areas_table')
  #   within ('#areas_table') do
  #     expect(page.body).to have_content ('Test Post Title')
  #   end
  #
  #
  #   save_and_open_page
  # end


end
