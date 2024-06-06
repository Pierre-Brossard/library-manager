require 'faker'

puts 'Destroying all instances...'

User.destroy_all
Book.destroy_all
Serie.destroy_all
Genre.destroy_all
BookGenre.destroy_all
Collection.destroy_all
FavoriteSerie.destroy_all

puts 'Done'

images = ['cityoforange.jpeg', 'dune.jpeg', 'greatgatsby.jpeg', 'lotr.jpeg']

puts 'Creating users and series...'

User.create(nickname: "John", email: "john@gmail.com", password: 123456, public: true)
User.create(nickname: "Maria", email: "maria@gmail.com", password: 123456)

Serie.create(name: "Serie 1", books_total: 5, status: "Finished")
Serie.create(name: "Serie 2", books_total: 5, status: "On going")

puts 'Done'

puts 'Creating books...'

10.times{
  b = Book.new(
      title: Faker::Book.unique.title,
      serie_number: rand(10),
      book_type: Book::TYPES.sample,
      serie: Serie.all.sample,
      description: Faker::Lorem.sentence(word_count: 15),
      isbn: "978 - 2 - 7177 - 2113 - 4",
      release: Date.today-rand(10000),
      author: Faker::Book.author,
      illustrator: Faker::Book.author,
      edition: Faker::Book.publisher,
      illustrations: ["dz2btx3jhn9pqpvpnolp", "dz2btx3jhn9pqpvpnolp", "dz2btx3jhn9pqpvpnolp"]
    )
  filename = images.sample
  b.cover_img.attach(io: File.open("app/assets/images/#{filename}"), filename: filename, content_type: "image/jpg")
  b.save!
}

15.times {
  Genre.create(name: Faker::Book.unique.genre)
}

puts 'Done'

puts 'Creating collections...'

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

puts 'Done'
