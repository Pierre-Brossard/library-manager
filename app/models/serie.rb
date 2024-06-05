class Serie < ApplicationRecord
  has_many :favorite_series
  has_many :books

  STATUS = ['En cours', 'Terminée']

  validates :name, presence: true
  validates :status, inclusion: {in: Serie::STATUS}
end
