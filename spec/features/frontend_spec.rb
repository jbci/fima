require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature "basic frontend" do
  before(:each) do
    #  Capybara.current_driver = :selenium
     @admin = FactoryGirl.create(:admin)
   end

   after(:all) do
     Capybara.use_default_driver
   end

  scenario "allow logged not logged in users", js: true do
    # login_as(@admin, :scope => :admin)
    visit root_path
    # save_and_open_page
    expect(page).to have_content 'municipio'
  end

  scenario "get_informed_path", js: true do
    # login_as(@admin, :scope => :admin)
    visit get_informed_path
    # save_and_open_page
    expect(find('#eval_indicator_form')).to be
    within '#eval_indicator_form' do
      chosen_select('s0i0t', from: '#eval_indicator_select')
      find('#eval_form_button').click
    end

    expect(find('#eval_indicator_table')).to be
  end

  scenario "initiatives_path", js: true do
    # login_as(@admin, :scope => :admin)
    visit initiatives_path
    # save_and_open_page
    expect(find('#initiatives_form')).to be
    within '#initiatives_form' do
      chosen_select('Providencia', from: '#initiatives_area_select')
      find('#initiatives_form_button').click
    end

    expect(find('#initiatives_list')).to be
  end



end
