class Book < ApplicationRecord
  belongs_to :serie
  has_many :book_genres
  has_many :genres, through: :book_genres
  has_many :collections
  has_many :users, through: :collections

  validates :title, presence: true, uniqueness: true
  validates :book_type, presence: true
end
