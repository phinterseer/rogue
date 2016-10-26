class Movie < ApplicationRecord
  has_many :screenings, dependent: :destroy
  has_many :screens, -> { uniq }, through: :screenings
  has_many :cinemas, -> { uniq }, through: :screens
end
