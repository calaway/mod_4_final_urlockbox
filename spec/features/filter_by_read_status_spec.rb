require "rails_helper"

RSpec.describe "User changes filter", :js => :true do
  context "to 'read'" do
    scenario "they see only read links" do
      user = User.create(email: "example@example.com", password: "secret")
      sign_in user
      read_link   = user.links.create(title: "Read",
                                      url: "http://read.com",
                                      read: true)
      unread_link = user.links.create(title: "Unread",
                                      url: "http://unread.com",
                                      read: false)

      visit root_path

      expect(page).to have_text("http://unread.com")

      select "Read", from: "Filter by read/unread"

      expect(page).to have_text("http://read.com")
      expect(page).to_not have_text("http://unread.com")
    end
  end
end
