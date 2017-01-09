require 'rails_helper'

RSpec.feature "Signed in user signs out", type: :feature do
  scenario "they are no longer signed in" do
    visit root_path
    click_on "Sign Up"
    fill_in "user[email]", with: "example@example.com"
    fill_in "user[password]", with: "secret"
    fill_in "user[password_confirmation]", with: "secret"
    click_on "Submit"

    click_on "Sign Out"

    expect(current_path).to eq login_path
    expect(page).to_not have_text "Sign Out"
    expect(page).to_not have_text "example@example.com"
    expect(page).to have_text "Sign Up"
  end
end
