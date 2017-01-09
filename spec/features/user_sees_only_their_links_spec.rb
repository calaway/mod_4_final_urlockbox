require "rails_helper"

RSpec.describe "User visits links page", :js => :true do
  xscenario "they see only their links" do
    user = User.create(email: "example@example.com", password: "secret")
    sign_in user
    user_link = user.links.create(title: "User's link", url: "http://user_link.com")
    other_link = Link.create(title: "Other link", url: "http://other_link.com")

    visit links_path

    expect(page).to have_text(user_link.title)
    expect(page).to have_text(user_link.url)
  end
end
