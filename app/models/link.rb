class Link < ApplicationRecord
  belongs_to :admin
  
  has_many :link_views, dependent: :destroy
  has_many :viewers, through: :link_views, source: :user
  def revenue
    (visit_count || 0) * 0.0001
  end
end
