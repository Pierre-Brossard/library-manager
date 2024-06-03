class Book < ApplicationRecord
  belongs_to :serie
  has_many :book_genres
  has_many :genres, through: :book_genres
  has_many :collections
  has_many :users, through: :collections

  validates :title, presence: true
  validates :type, presence: true
end
