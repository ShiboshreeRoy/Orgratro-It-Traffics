class UserProfileController < ApplicationController
  before_action :authenticate_admin!  # Make sure only admins can access

  def advatiser
    @users = User.order(created_at: params[:sort] == "asc" ? :asc : :desc)
    @links = Link.all

    @total_user = @users.count
    @total_active_link = @links.count
    @total_revinue = Link.sum(:revenue_amount) # optional
    @total_link_visits = Link.sum(:visit_count) # ✅ This is the line you need

    @instructions = Instruction.all
    @top_users = User
    .joins(:instruction_clicks)
    .group("users.id")
    .select("users.*, COUNT(instruction_clicks.id) as clicks_count")
    .order("clicks_count DESC")
    .limit(10)

  end


  def track_link
    
    @link = Link.find(params[:id])
    @link.increment!(:visit_count)
    redirect_to @link.url, notice: "Tracking recorded."
  end

  
  def publisher
    @user = User.find(params[:id])
    # Publisher-specific logic
  end
end
