class InstructionClick < ApplicationRecord
  belongs_to :instruction
  belongs_to :user
end
