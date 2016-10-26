class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :screen
  has_one :cinema, through: :screen
end
