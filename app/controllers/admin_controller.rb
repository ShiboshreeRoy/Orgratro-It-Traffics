class AdminController < ApplicationController
  def index
    @users = User.all
    @users = User.find(params[:id]) if params[:id].present?
    @links = Link.all
    @links = Link.find(params[:id]) if params[:id].present?
    
    @instructions = Instruction.all
    # Fetching the total number of links and users
    @total_links = Link.count
    @total_users = User.count
    # Fetching the most recent users
    @recent_users = User.order(created_at: :desc).limit(5)



    @top_users = User
    .joins(:instruction_clicks)
    .group("users.id")
    .select("users.*, COUNT(instruction_clicks.id) as clicks_count")
    .order("clicks_count DESC")
    .limit(10)
  end
end
