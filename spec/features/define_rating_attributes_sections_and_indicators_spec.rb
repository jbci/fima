require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature "define rating, sections, and indicators" do

  scenario "allow logged in admin to visit backend", js: true do
    @admin = FactoryGirl.create(:admin)
    login_as(@admin, :scope => :admin)
    visit '/backend/rating_definition'
    # save_and_open_page
    expect(page).to have_content 'Rating'
  end

  scenario "translates page with locale parameter", js: true do
    @admin = FactoryGirl.create(:admin)
    login_as(@admin, :scope => :admin)
    visit '/backend/rating_definition?locale=es'
    # save_and_open_page
    expect(page).to have_content 'Índice'
  end

  scenario "allow logged in admin to modify rating title and description", js: true do
    @admin = FactoryGirl.create(:admin)
    login_as(@admin, :scope => :admin)
    visit '/backend/rating_definition'
    # within("//li[@id='employee']") do
    within("form#rating_definition_form") do
          fill_in 'Title', :with => 'Jimmy'
          fill_in 'Description', :with => 'Jimmy is a punk rocker'
          # click_link('Add new Section')
          # click_link('Add new Indicator')
          click_button('Update Rating')
          save_and_open_page
    end
    login_as(@admin, :scope => :admin)
    visit '/backend/rating_definition'
    within("form#rating_definition_form") do
          title_field = find('#rating_title')
          expect(title_field.value).to eq('Jimmy')
          description_field = find('#rating_description')
          expect(description_field.value).to eq('Jimmy is a punk rocker')
    end
  end

  scenario "Create a new section", js: true do
    @admin = FactoryGirl.create(:admin)
    login_as(@admin, :scope => :admin)
    visit '/backend/rating_definition'
    within("#rating_definition_form") do
          click_on('Add new Section')
          expect(find('#section_0')).to be
          find('#section_0')
    end
    within("div#section_0") do
      fill_in 'Title', with: 'Section 0 Title'
      fill_in 'Description', with: 'Section 0 Description'
      click_on('Add new Indicator')
    end
    within("#rating_definition_form") do
      click_on('Update Rating')
    end
    save_and_open_page
    login_as(@admin, :scope => :admin)
    visit '/backend/rating_definition'
    within("div#section_0") do
      sleep 5
      title_field = find('#section_0_title')
      expect(title_field.value).to eq('Section 0 Title')
      description_field = find('#section_0_description')
      expect(description_field.value).to eq('Section 0 Description')
    end

  end


end
