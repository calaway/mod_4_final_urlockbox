require "rails_helper"

RSpec.describe "User searches", :js => :true do
  scenario "they see only matching results" do
    user = User.create(email: "example@example.com", password: "secret")
    sign_in user
    user.links.create(title: "Turing", url: "http://turing.io")
    user.links.create(title: "Example", url: "http://z.com")
    user.links.create(title: "z in title", url: "http://Example.com")

    visit root_path

    expect(page).to have_text("http://turing.io")

    fill_in "filter-by-text", with: "z"

    expect(page).to have_text("http://z.com")
    expect(page).to have_text("z in title")
    expect(page).to_not have_text("http://turing.io")
  end
end
