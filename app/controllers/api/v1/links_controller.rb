class Api::V1::LinksController < ApplicationController
  before_action :authenticate_api!

  def index
    render json: current_user.links
  end

  def create
    @link = current_user.links.new link_params
    if @link.save
      render json: @link, status: 201
    else
      render json: @link.errors.full_messages.join(". "), status: 500
    end
  end

  def update
    @link = Link.find params[:id]
    @link.toggle(:read) if params[:toggle_read]
    @link.assign_attributes link_params
    just_read = @link.read_changed? && @link.read
    if @link.save
      Read.create(link: @link) if just_read
      render json: @link, status: 201
    else
      render json: @link.errors.full_messages.join(". "), status: 500
    end
  end

  private

  def link_params
    params.permit(:title, :url, :read)
  end
end
