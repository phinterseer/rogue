class Screen < ApplicationRecord
  belongs_to :cinema
  has_many :screenings, dependent: :destroy
  has_many :movies, -> { uniq }, through: :screenings
end
