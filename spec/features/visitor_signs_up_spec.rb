require 'rails_helper'

RSpec.feature "VisitorSignsUps", type: :feature do
  context "with valid information" do
    scenario "they are logged in" do
      visit root_path

      expect(current_path).to eq signup_path
      expect(page).to_not have_text "Sign Out"

      click_on "Sign Up"
      fill_in "user[email]", with: "example@example.com"
      fill_in "user[password]", with: "secret"
      fill_in "user[password_confirmation]", with: "secret"
      click_on "Submit"

      expect(current_path).to eq root_path
      expect(page).to have_text "Sign Out"
      expect(page).to_not have_text "Sign Up"
      expect(page).to have_text "example@example.com"
    end
  end

  context "with mismatched password & confirmation" do
    scenario "they are redirected back" do
      visit root_path
      click_on "Sign Up"

      fill_in "user[email]", with: "example@example.com"
      fill_in "user[password]", with: "secret1"
      fill_in "user[password_confirmation]", with: "secret2"
      click_on "Submit"

      expect(current_path).to eq signup_path
      expect(page).to_not have_text "Sign Out"
      expect(page).to_not have_text "example@example.com"
      expect(page).to have_text "Sign Up"
      expect(page).to have_text "Password confirmation doesn't match Password"
    end
  end
end
