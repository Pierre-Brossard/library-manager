require 'faker'

User.destroy_all
Book.destroy_all
Serie.destroy_all
Genre.destroy_all
BookGenre.destroy_all
Collection.destroy_all
FavoriteSerie.destroy_all


User.create(nickname: "John", email: "john@gmail.com", password: 123456, public: true)
User.create(nickname: "Maria", email: "maria@gmail.com", password: 123456)

Serie.create(name: "Serie 1", books_total: 5, status: "Finished")
Serie.create(name: "Serie 2", books_total: 5, status: "On going")

10.times{
  Book.create(
      title: Faker::Book.title,
      serie_number: rand(10),
      book_type: ["manga", "Bande Dessine", "roman"].sample,
      cover_url: "dz2btx3jhn9pqpvpnolp",
      serie: Serie.all.sample,
      description: Faker::Lorem.sentence(word_count: 15),
      isbn: "978 - 2 - 7177 - 2113 - 4",
      release: Date.today-rand(10000),
      author: Faker::Book.author,
      illustrator: Faker::Book.author,
      edition: Faker::Book.publisher,
      illustrations: ["dz2btx3jhn9pqpvpnolp", "dz2btx3jhn9pqpvpnolp", "dz2btx3jhn9pqpvpnolp"]
    )
}

3.times {
  Genre.create(name: Faker::Book.genre)
}

Book.all.each do |book|
  BookGenre.create(
    book: book,
    genre: Genre.all.sample
  )

  Collection.create(
    comment: Faker::Lorem.sentence(word_count: 15),
    is_read: [false, true].sample,
    is_favorited: [false, true].sample,
    book: book,
    user: User.all.sample
  )
end

User.all.each do |user|
  FavoriteSerie.create(
    user: user,
    serie: Serie.all.sample
  )
end
