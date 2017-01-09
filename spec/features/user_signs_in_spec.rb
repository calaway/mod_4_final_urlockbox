require 'rails_helper'

RSpec.feature "User signs in", type: :feature do
  context "with valid information" do
    scenario "they are logged in" do
      user = User.create(email: "example@example.com", password: "secret")

      visit root_path
      click_on "Sign In"
      fill_in "email", with: "example@example.com"
      fill_in "password", with: "secret"
      click_on "Submit"

      expect(current_path).to eq root_path
      expect(page).to have_text "Sign Out"
      expect(page).to_not have_text "Sign Up"
      expect(page).to have_text "example@example.com"
      expect(page).to have_text "Sign In Successful"
    end
  end

  context "with invalid information" do
    scenario "they are not logged in" do
      user = User.create(email: "example@example.com", password: "secret")

      visit root_path
      click_on "Sign In"
      fill_in "email", with: "example@example.com"
      fill_in "password", with: "wrong_password"
      click_on "Submit"

      expect(current_path).to eq login_path
      expect(page).to_not have_text "Sign Out"
      expect(page).to have_text "Sign In"
      expect(page).to have_text "Sign In Unsuccessful"
    end
  end
end
