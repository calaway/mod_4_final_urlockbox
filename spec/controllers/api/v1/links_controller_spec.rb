require 'rails_helper'

RSpec.describe Api::V1::LinksController, type: :controller do
  context "Visitor is not logged in" do
    scenario "they receive an unauthorized response" do
      post :create, params: {title: "Example", url: "http://example.com"}

      expect(response).to have_http_status(401)
    end
  end

  context "api/v1/links#create" do
    context "with valid url" do
      it "saves the link" do
        user = User.create(email: "example@example.com", password: "secret")
        sign_in user
        base = user.links.count

        post :create, params: {title: "Example", url: "http://example.com"}

        expect(response).to have_http_status(:success)
        expect(user.links.count).to eq(base + 1)
        expect(user.links.last.url).to eq("http://example.com")
      end
    end

    context "with invalid url" do
      it "does not save the link" do
        user = User.create(email: "example@example.com", password: "secret")
        sign_in user
        base = user.links.count

        post :create, params: {title: "Example", url: "bad_url.com"}

        expect(response).to have_http_status(500)
        expect(user.links.count).to eq(base)
      end
    end
  end

  context "api/v1/links#update" do
    scenario "toggles unread to read" do
      user = User.create(email: "example@example.com", password: "secret")
      sign_in user
      link = Link.create(title: "Turing", url: "http://turing.io", read: false)
      read_count = Read.count

      post :update, params: {id: link.id, toggle_read: true}

      expect(response).to have_http_status(:success)
      expect(link.reload.read).to eq(true)
      expect(Read.count).to eq(read_count + 1)
    end

    scenario "toggles read to unread" do
      user = User.create(email: "example@example.com", password: "secret")
      sign_in user
      link = Link.create(title: "Turing", url: "http://turing.io", read: true)
      read_count = Read.count

      post :update, params: {id: link.id, toggle_read: true}

      expect(response).to have_http_status(:success)
      expect(link.reload.read).to eq(false)
      expect(Read.count).to eq(read_count)
    end
  end
end
