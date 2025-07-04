class LinkView < ApplicationRecord
  belongs_to :user
  belongs_to :link

  validates :viewed_at, presence: true
end
