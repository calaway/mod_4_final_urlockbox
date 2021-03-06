require "rails_helper"

RSpec.describe "User submits a link", :js => :true do
  context "with a valid URL" do
    scenario "they see the new link" do
      user = User.create(email: "example@example.com", password: "secret")
      sign_in user

      visit "/"
      fill_in "Title:", :with => "Turing"
      fill_in "URL:", :with => "http://turing.io"
      click_on "Add Link"

      within('#links-list') do
        expect(page).to have_text("Turing")
        expect(page).to have_text("http://turing.io")
      end
    end
  end

  context "with an invalid URL" do
    scenario "the link is not created" do
      user = User.create(email: "example@example.com", password: "secret")
      sign_in user

      visit "/"
      fill_in "Title:", :with => "Turing"
      fill_in "URL:", :with => "invalid_url"
      click_on "Add Link"

      expect(page).to_not have_text("Turing")
      expect(page).to_not have_text("http://turing.io")
      expect(page).to have_text("Url is not a valid URL")
    end
  end

  context "without a title" do
    scenario "the link is not created" do
      user = User.create(email: "example@example.com", password: "secret")
      sign_in user

      visit "/"
      fill_in "Title:", :with => ""
      fill_in "URL:", :with => "http://turing.io"
      click_on "Add Link"

      expect(page).to_not have_text("http://turing.io")
      expect(page).to have_text("Title can't be blank")
    end
  end

  context "without a URL" do
    scenario "the link is not created" do
      user = User.create(email: "example@example.com", password: "secret")
      sign_in user

      visit "/"
      fill_in "Title:", :with => "Turing"
      fill_in "URL:", :with => ""
      click_on "Add Link"

      expect(page).to_not have_text("Turing")
      expect(page).to have_text("Url can't be blank")
    end
  end
end
