class Cinema < ApplicationRecord
  has_many :screens, dependent: :destroy
  has_many :screenings, through: :screens
  has_many :movies, -> { uniq }, through: :screenings

  def update_screenings_for date

  end

end
