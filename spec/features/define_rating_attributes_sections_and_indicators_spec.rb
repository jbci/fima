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
          fill_in 'rating_title', :with => 'Jimmy'
          fill_in 'rating_description', :with => 'Jimmy is a punk rocker'
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

    last_section = Section.count

    within("#section_new_sections") do
      fill_in 'Title', with: 'Section ' + last_section.to_s + ' Title'
      fill_in 'Description', with: 'Section ' + last_section.to_s + ' Description'
    end

    within("#rating_definition_form") do
      find('#rating_commit_button').click
      page.driver.browser.switch_to.alert.accept
    end


    expect(find('#section_' + last_section.to_s)).to be
    within('#section_' + last_section.to_s) do
      title_field = find('#section_' + last_section.to_s + '_title')
      expect(title_field.value).to eq('Section ' + last_section.to_s + ' Title')
      description_field = find('#section_' + last_section.to_s + '_description')
      expect(description_field.value).to eq('Section ' + last_section.to_s + ' Description')
    end
  end

  scenario "Create a new section and two new indicator", js: true do
    login_as(@admin, :scope => :admin)
    visit '/backend/rating_definition'
    within("#rating_definition_form") do
          click_on('Add new Section')
          expect(find('#section_new_sections')).to be
    end
    section_index = Section.count


    within("#section_new_sections") do
      fill_in 'Title', with: 'Section ' + section_index.to_s + ' Title'
      fill_in 'Description', with: 'Section ' + section_index.to_s + ' Description'
    end

    within("#rating_definition_form") do
      find('#rating_commit_button').click
      page.driver.browser.switch_to.alert.accept
    end

    section_index = Section.count 


    within('#section_' + section_index.to_s) do
      click_on('Add new Indicator')
      sleep 1
      expect(find('#section_' + section_index.to_s + '_indicator_new_indicators')).to be
    end


    within('#section_' + section_index.to_s + '_indicator_new_indicators') do
      fill_in 'Title', with: 'Section ' + section_index.to_s + ' - Indicator 0 - Title'
      fill_in 'Description', with: 'Section ' + section_index.to_s + ' - Indicator 0 - Description'
    end

    within('#rating_definition_form') do
      find('#section_' + section_index.to_s + '_commit_button').click
      #page.driver.browser.switch_to.alert.accept
    end


    within('#section_' + section_index.to_s) do
      expect(find('#section_' + section_index.to_s + '_indicator_0')).to be
      click_on('Add new Indicator')
      sleep 1
      expect(find('#section_' + section_index.to_s + '_indicator_new_indicators')).to be
    end

    within('#section_' + section_index.to_s + '_indicator_new_indicators') do
      fill_in 'Title', with: 'Section ' + section_index.to_s + ' - Indicator 1 - Title'
      fill_in 'Description', with: 'Section ' + section_index.to_s + ' - Indicator 1 - Description'
    end

    within('#rating_definition_form') do
      find('#section_' + section_index.to_s + '_commit_button').click
      #page.driver.browser.switch_to.alert.accept
      # wait_for_ajax
    end

    # sleep 60
    within('div#section_' + section_index.to_s) do
      title_field = find('#section_' + section_index.to_s + '_title')
      expect(title_field.value).to eq('Section ' + section_index.to_s + ' Title')
      description_field = find('#section_' + section_index.to_s + '_description')
      expect(description_field.value).to eq('Section ' + section_index.to_s + ' Description')
    end

    within('#section_' + section_index.to_s + '_indicator_0') do
      title_field = find('#section_' + section_index.to_s + '_indicator_0_title')
      expect(title_field.value).to eq('Section ' + section_index.to_s + ' - Indicator 0 - Title')
      description_field = find('#section_' + section_index.to_s + '_indicator_0_description')
      expect(description_field.value).to eq('Section ' + section_index.to_s + ' - Indicator 0 - Description')
    end

    within('#section_' + section_index.to_s + '_indicator_1') do
      title_field = find('#section_' + section_index.to_s + '_indicator_1_title')
      expect(title_field.value).to eq('Section ' + section_index.to_s + ' - Indicator 1 - Title')
      description_field = find('#section_' + section_index.to_s + '_indicator_1_description')
      expect(description_field.value).to eq('Section ' + section_index.to_s + ' - Indicator 1 - Description')
    end

    # save_and_open_page

  end

  scenario 'delete section', js: true do
    section_1 = FactoryGirl.create(:section_1)
    section_2 = FactoryGirl.create(:section_2)
    rating = Rating.first
    rating.sections << section_1
    rating.sections << section_2
    rating.save

    section_count = rating.sections.count

    login_as(@admin, :scope => :admin)
    visit '/backend/rating_definition'


    find('#section_0')

    within('#section_0') do
      click_on('Delete Section')
      page.driver.browser.switch_to.alert.accept
    end

    within('#rating_definition_form') do
      find('#rating_commit_button').click
      page.driver.browser.switch_to.alert.accept
      wait_for_ajax
    end

    rating = Rating.first
    expect(rating.sections.count).to eq(section_count - 1)

  end

end
