require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature "define rating, sections, and indicators" do
  before(:each) do
     Capybara.current_driver = :selenium
     @admin = FactoryGirl.create(:admin)
   end
   after(:all) do
     Capybara.use_default_driver
   end

  scenario "allow logged in admin to visit backend", js: true do
    login_as(@admin, :scope => :admin)
    visit '/backend/rating_definition'
    # save_and_open_page
    expect(page).to have_content 'Rating'
  end

  scenario "translates page with locale parameter", js: true do
    login_as(@admin, :scope => :admin)
    visit '/backend/rating_definition?locale=es'
    # save_and_open_page
    expect(page).to have_content 'Índice'
  end

  scenario "allow logged in admin to modify rating title and description", js: true do
    login_as(@admin, :scope => :admin)
    visit '/backend/rating_definition'
    within("form#rating_definition_form") do
          fill_in 'Title', :with => 'Jimmy'
          fill_in 'Description', :with => 'Jimmy is a punk rocker'
          click_button('Update Rating')
          page.driver.browser.switch_to.alert.accept
          # wait_for_ajax
    end

    expect(find('#rating_definition_form')).to be
    within("#rating_definition_form") do
          title_field = find('#rating_title')
          expect(title_field.value).to eq('Jimmy')
          description_field = find('#rating_description')
          expect(description_field.value).to eq('Jimmy is a punk rocker')
    end
  end

  scenario "Create a new section", js: true do
    login_as(@admin, :scope => :admin)
    visit '/backend/rating_definition'
    within("#rating_definition_form") do
          click_on('Add new Section')
          expect(find('#section_new_sections')).to be
    end

    within("#section_new_sections") do
      fill_in 'Title', with: 'Section 0 Title'
      fill_in 'Description', with: 'Section 0 Description'
    end

    within("#rating_definition_form") do
      find('#rating_commit_button').click
      page.driver.browser.switch_to.alert.accept
    end

    expect(find('#section_0')).to be
    within("#section_0") do
      title_field = find('#section_0_title')
      expect(title_field.value).to eq('Section 0 Title')
      description_field = find('#section_0_description')
      expect(description_field.value).to eq('Section 0 Description')
    end
  end

  scenario "Create a new section and two new indicator", js: true do
    login_as(@admin, :scope => :admin)
    visit '/backend/rating_definition'
    within("#rating_definition_form") do
          click_on('Add new Section')
          expect(find('#section_new_sections')).to be
    end

    within("#section_new_sections") do
      fill_in 'Title', with: 'Section 0 Title'
      fill_in 'Description', with: 'Section 0 Description'
    end

    within("#rating_definition_form") do
      find('#rating_commit_button').click
      page.driver.browser.switch_to.alert.accept
    end

    within("#section_0") do
      click_on('Add new Indicator')
      expect(find('#section_0_indicator_new_indicators')).to be
    end


    within("#section_0_indicator_new_indicators") do
      fill_in 'Title', with: 'Section 0 - Indicator 0 - Title'
      fill_in 'Description', with: 'Section 0 - Indicator 0 - Description'
    end

    within("#rating_definition_form") do
      find('#section_0_commit_button').click
      #page.driver.browser.switch_to.alert.accept
    end


    within("#section_0") do
      expect(find('#section_0_indicator_0')).to be
      click_on('Add new Indicator')
      expect(find('#section_0_indicator_new_indicators')).to be
    end

    within("#section_0_indicator_new_indicators") do
      fill_in 'Title', with: 'Section 0 - Indicator 1 - Title'
      fill_in 'Description', with: 'Section 0 - Indicator 1 - Description'
    end

    within("#rating_definition_form") do
      find('#section_0_commit_button').click
      #page.driver.browser.switch_to.alert.accept
      # wait_for_ajax
    end

    within("div#section_0") do
      title_field = find('#section_0_title')
      expect(title_field.value).to eq('Section 0 Title')
      description_field = find('#section_0_description')
      expect(description_field.value).to eq('Section 0 Description')
    end

    within("#section_0_indicator_0") do
      title_field = find('#section_0_indicator_0_title')
      expect(title_field.value).to eq('Section 0 - Indicator 0 - Title')
      description_field = find('#section_0_indicator_0_description')
      expect(description_field.value).to eq('Section 0 - Indicator 0 - Description')
    end


    within("#section_0_indicator_1") do
      title_field = find('#section_0_indicator_1_title')
      expect(title_field.value).to eq('Section 0 - Indicator 1 - Title')
      description_field = find('#section_0_indicator_1_description')
      expect(description_field.value).to eq('Section 0 - Indicator 1 - Description')
    end

    save_and_open_page

  end

  scenario "delete section", js: true do
    section_1 = FactoryGirl.create(:section_1)
    section_2 = FactoryGirl.create(:section_2)
    rating = Rating.first
    rating.sections << section_1
    rating.sections << section_2
    rating.save

    login_as(@admin, :scope => :admin)
    visit '/backend/rating_definition'


    find('#section_0')

    within("#section_0") do
      click_on('Delete Section')
      page.driver.browser.switch_to.alert.accept
    end

    within("#rating_definition_form") do
      find('#rating_commit_button').click
      page.driver.browser.switch_to.alert.accept
      wait_for_ajax
    end

    rating = Rating.first
    expect(rating.sections.count).to eq(1)

  end

end
