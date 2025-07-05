class HomeController < ApplicationController
  def index
    @top_users = User
    .joins(:instruction_clicks)
    .group("users.id")
    .select("users.*, COUNT(instruction_clicks.id) as clicks_count")
    .order("clicks_count DESC")
    .limit(10)
  end

  def features
  end

  def pricing
  end

  def contact
  end
end
