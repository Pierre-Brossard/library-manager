class Book < ApplicationRecord
  belongs_to :serie, optional: true
  has_many :book_genres, dependent: :destroy
  has_many :genres, through: :book_genres
  has_many :collections
  has_many :users, through: :collections

  has_one_attached :cover_img

  include PgSearch::Model
  multisearchable against: [:title, :author, :illustrator]

  TYPES = ['Roman', 'Manga', 'BD', 'Poesie', 'Manuel', 'Livre illustré']


  validates :title, presence: true, uniqueness: true
  validates :book_type, presence: true, inclusion: { in: Book::TYPES }
end
