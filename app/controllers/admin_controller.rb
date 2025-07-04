class AdminController < ApplicationController
  def index
    @users = User.all
    @users = User.find(params[:id]) if params[:id].present?
    @links = Link.all
    @links = Link.find(params[:id]) if params[:id].present?
    
    # Fetching the total number of links and users
    @total_links = Link.count
    @total_users = User.count

    # Fetching the most recent users
    @recent_users = User.order(created_at: :desc).limit(5)
  end
end
