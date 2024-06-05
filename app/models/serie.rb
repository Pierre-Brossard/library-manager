class Serie < ApplicationRecord
  has_many :favorite_series
  has_many :books

  include PgSearch::Model
  multisearchable against: [:name]

  STATUS = ['En cours', 'Terminée']

  validates :name, presence: true
end
