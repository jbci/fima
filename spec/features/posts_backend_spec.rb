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
    Post.destroy_all
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


    # save_and_open_page
  end

  scenario "update the second post", js: true do
    post_1 = FactoryGirl.create(:post)
    post_2 = FactoryGirl.create(:post_1)
    post_3 = FactoryGirl.create(:post_2)
    login_as(@admin, :scope => :admin)
    visit '/backend/posts'

    expect(find("#posts_table")).to be
    within("#posts_table")do
      expect(find("#post_2")).to be
      within('#post_2') do
        find('a', :text => 'Edit').click
      end
    end
    expect(find("#post-modal")).to be
    within("#post-modal") do
      fill_in 'Title', :with => 'Test Update Post Title'
      fill_in 'Body', :with => 'Test Update Post Body'
      option = find_all('#post_comuna_dropdown option').last
      option.select_option
      find('#post_modal_button').click
      wait_for_ajax
    end

    expect(find("#posts_table")).to be
    within("#posts_table")do
      expect(find("#post_2")).to be
      within('#post_2') do
        expect(find('td', :text => 'Test Update Post Title')).to be
      end
    end
  end

  scenario "delete the third post", js: true do
    post_1 = FactoryGirl.create(:post)
    post_2 = FactoryGirl.create(:post_1)
    post_3 = FactoryGirl.create(:post_2)
    login_as(@admin, :scope => :admin)
    visit '/backend/posts'
    initial_post_count = Post.count
    # expect(initial_post_count).to eq(3)

    expect(find("#posts_table")).to be
    within("#posts_table")do
      expect(find("#post_3")).to be
      within('#post_3') do
        find('a', :text => 'Destroy').click
        page.driver.browser.switch_to.alert.accept
        wait_for_ajax
      end
    end

    post = Post.count
    expect(post).to eq(initial_post_count - 1)
    # save_and_open_page
  end


end
