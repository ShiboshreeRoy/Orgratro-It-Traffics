class Link < ApplicationRecord
  belongs_to :admin

  def revenue
    (visit_count || 0) * 0.0001
  end
end
