require "spec_helper"

feature "user has a list of foods", focus: true do

  # User Story
  # ----------
  # As a user
  # I want to add a food item to my list
  # So that I can track which foods I want to eat

  # Acceptance Criteria
  # -------------------
  # * I must enter a food item
  # * I must enter a vendor
  # * If I forget a field, errors are displayed

  before(:each) do
    reset_csv
  end

  context "create" do
    scenario "user creates a food item" do
      visit '/'

      click_link 'Add a Noms!'

      fill_in 'Food Item', with: 'Cheese Curds'
      fill_in 'Vendor', with: 'The Original Deep Fried Cheese Curds'

      click_button 'Submit'

      expect(page).to have_content('Cheese Curds')
    end

    scenario "user leaves a field blank" do
      visit '/'

      click_link 'Add a Noms!'

      fill_in 'Food Item', with: 'Fried Pickles'

      click_button 'Submit'

      expect(page).to have_content('Please fill in all fields')
    end
  end
end
