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
    login_as(@admin, :scope => :admin)
    visit '/backend/areas'
    expect(find('#area_levels_table')).to be
  end

  scenario "opens area popup to create a new area_level and insert a row to area_levels_table ", js: true do
    login_as(@admin, :scope => :admin)
    visit '/backend/areas'

    find('#new_area_level_link').click
    expect(find('#area_level-modal')).to be

    within("#area_level-modal") do
      fill_in 'Name', :with => 'Test Area Level Name'
      find('#area_level_modal_button').click
    end

    wait_for_ajax
    find('#area_levels_table')
    within ('#area_levels_table') do
      expect(page.body).to have_content ('Test Area Level Name')
    end
  end

  scenario "delete the last created area_level", js: true do
    area_level = FactoryGirl.create(:area_level)
    login_as(@admin, :scope => :admin)
    visit '/backend/areas'

    area_levels_count = all("table#area_levels_table tr").count

    expect(find("#area_levels_table")).to be
    expect(find("#area_level_" + area_level.id.to_s)).to be

    find("#area_levels_table")
    within("#area_levels_table") do
      expect(find("tr#area_level_" + area_level.id.to_s)).to be
      within("#area_level_" + area_level.id.to_s) do
        find("a", :text => 'Destroy').click
        page.driver.browser.switch_to.alert.accept
      end
    end
    expect(find("table#area_levels_table")).to be
    expect(all("table#area_levels_table tr").count).to eq(area_levels_count - 1)
  end

  scenario "update area_level name", js: true do
    area_level = FactoryGirl.create(:area_level)
    login_as(@admin, :scope => :admin)
    visit '/backend/areas'

    area_levels_count = all("table#area_levels_table tr").count

    expect(find("#area_levels_table")).to be
    expect(find("#area_level_" + area_level.id.to_s)).to be

    find("#area_levels_table")
    within("#area_levels_table") do
      expect(find("tr#area_level_" + area_level.id.to_s)).to be
      within("#area_level_" + area_level.id.to_s) do
        find("a", :text => 'Edit').click
      end
    end

    expect(find('#area_level-modal')).to be

    within("#area_level-modal") do
      fill_in 'Name', :with => 'Update Area Level Name'
      find('#area_level_modal_button').click
    end
    sleep 20
    find("#area_levels_table")
    within("#area_levels_table") do
      find("#area_level_" + area_level.id.to_s)
      wait_for_ajax
      expect(find("#area_level_" + area_level.id.to_s)).to be
      within("#area_level_" + area_level.id.to_s) do
        # expect(find("td", :text => 'Update Area Level Name')).to be
        expect(find("tr#area_level_" + area_level.id.to_s)).to have_content('Update Area Level Name')
      end
    end

  end

end
