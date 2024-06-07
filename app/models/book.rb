class Book < ApplicationRecord
  belongs_to :serie, optional: true
  has_many :book_genres, dependent: :destroy
  has_many :genres, through: :book_genres
  has_many :collections
  has_many :users, through: :collections

  has_one_attached :cover_img

  TYPES = ['Roman', 'Manga', 'BD', 'Poesie']
  include PgSearch::Model
  multisearchable against: [:title, :author, :illustrator]

  pg_search_scope :global_search,
    against: [:title, :author, :illustrator],
    associated_against: {serie: :name, genres: :name},
    using: {trigram: {}, tsearch: {prefix: true}}

  validates :title, presence: true, uniqueness: true
  validates :book_type, presence: true, inclusion: { in: Book::TYPES }

end
