class Serie < ApplicationRecord
  has_many :favorite_series
  has_many :books

  validates :name, presence: true
end
