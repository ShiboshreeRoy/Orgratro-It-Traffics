class UserProfileController < ApplicationController
  before_action :authenticate_admin!  # Make sure only admins can access

  def advatiser
    @users = User.all
    @links = Link.all

    @total_user = @users.count
    @total_active_link = @links.count
    @total_revinue = Link.sum(:revenue_amount)  # Optional: needs revenue_amount column
  end

  def track_link
    @link = Link.find(params[:id])
    @link.increment!(:visit_count)
    redirect_to @link.url, notice: "Tracking recorded."
  end

  def publisher
    # Publisher-specific logic
  end
end
