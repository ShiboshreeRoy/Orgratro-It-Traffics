class Instruction < ApplicationRecord

  belongs_to :user
  has_many :instruction_clicks
end
