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
    visit '/backend/evaluations'
    # save_and_open_page
    expect(page).to have_content 'Evaluations'
  end

  scenario "select section(#eval_section_select) and indicator(#eval_indicator_select) and expect to find a table of evaluations(#eval_indicator_table)", js: true do
    login_as(@admin, :scope => :admin)
    visit '/backend/evaluations'

    expect(find('#eval_indicator_form')).to be
    within('#eval_indicator_form') do
      # expect(find('#eval_indicator_select')).to be
      chosen_select('s0i0t', from: '#eval_indicator_select')
      find('#eval_form_button').click
    end
    wait_for_ajax
    expect(find('#eval_indicator_table')).to be

  end




end
