require "rails_helper"

RSpec.describe "Link status", :js => :true do
  context "starts as unread" do
    context "user marks it as read" do
      scenario "the read status becomes true" do
        user = User.create(email: "example@example.com", password: "secret")
        link = user.links.create(title: "Turing", url: "http://turing.io", read: false)
        sign_in user

        visit root_path

        expect(page).to_not have_css(".read-link")
        within "#link-#{link.id}" do
          expect(page).to have_text("false")
        end

        within "#link-#{link.id}" do
          click_on "Mark as Read"
        end

        expect(page).to have_css(".read-link")
        within "#link-#{link.id}" do
          expect(page).to have_text("true")
          expect(page).to have_button("Mark as Unread")
        end
      end
    end
  end

  context "starts as read" do
    context "user marks it as unread" do
      scenario "the read status becomes false" do
        user = User.create(email: "example@example.com", password: "secret")
        link = user.links.create(title: "Turing", url: "http://turing.io", read: true)
        sign_in user

        visit root_path

        expect(page).to have_css(".read-link")
        within "#link-#{link.id}" do
          expect(page).to have_text("true")
        end

        within "#link-#{link.id}" do
          click_on "Mark as Unread"
        end

        expect(page).to_not have_css(".read-link")
        within "#link-#{link.id}" do
          expect(page).to have_text("false")
          expect(page).to have_button("Mark as Read")
        end
      end
    end
  end
end
