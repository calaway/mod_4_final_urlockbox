class LinksController < ApplicationController
  before_action :authenticate!

  def index
    @hot_links = Link.hot
  end
end
