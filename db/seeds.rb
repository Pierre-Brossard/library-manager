require 'faker'

INITIAL_GENRES = ['Fantasy', 'Science-fiction', 'Romance', 'Histoire', 'Shonen', 'Seinen', 'Shoujo', 'Jeunesse', 'Fantastique', 'Biographie', 'Thriller', 'Policier', 'Mélo', 'Conte']


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

john = User.create(nickname: "John", email: "john@gmail.com", password: 123456, public: true)
User.create(nickname: "Maria", email: "maria@gmail.com", password: 123456)

Serie.create(name: "Super série", books_total: 7, status: "Terminée")
Serie.create(name: "Mauvaise série", books_total: 5, status: 'En cours')

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

INITIAL_GENRES.each { |name|
  Genre.create(name: name)
}

puts 'Done'

puts 'Creating collections...'

Book.all.each do |book|
  (1 + rand(2)).times do
    BookGenre.create(
      book: book,
      genre: Genre.all.sample
    )
  end

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

puts 'other seeds'

croisee_serie = Serie.create(name: "À la croisée des mondes", books_total: 3, status: "Terminée")

cr = Book.new({
  title: 'Les Royaumes du Nord',
  serie_number: 1,
  book_type: 'Roman',
  serie: croisee_serie,
  description: "Élevée dans le très austère Jordan College à Oxford, Lyra Belacqua accompagnée de son dæmon Pantalaimon, apprend accidentellement l'existence de la Poussière, une étrange particule élémentaire que le Magisterium (l'organe exécutif de l'Église) pense être la conséquence du Péché originel.",
  author: 'Philip Pullman',
  release: Date.new(1998),
  edition: 'Gallimard'
})
cr.cover_img.attach(io: File.open("app/assets/images/croisee1.jpg"), filename: 'croisee1', content_type: "image/jpg")
cr.save!
Collection.create(
    comment: Faker::Lorem.sentence(word_count: 15),
    is_read: [false, true].sample,
    is_favorited: [false, true].sample,
    book: cr,
    user: john
  )

cr = Book.create({
  title: 'La Tour des anges',
  serie_number: 2,
  book_type: 'Roman',
  serie: croisee_serie,
  description: "Lyra entre dans un autre monde, celui de Cittàgazze, dont les adultes sont absents à cause de créatures mangeuses d'âmes appelées Spectres qui ont pour cibles tous les humains ayant passé la puberté. Ici, Lyra rencontre Will Parry, un garçon de douze ans qui vient de notre monde et qui est arrivé dans celui-ci après avoir tué accidentellement un homme pour protéger sa mère malade.",
  author: 'Philip Pullman',
  release: Date.new(2000),
  edition: 'Gallimard'
})
cr.cover_img.attach(io: File.open("app/assets/images/croisee2.jpg"), filename: 'croisee2', content_type: "image/jpg")
cr.save!

Collection.create(
    comment: Faker::Lorem.sentence(word_count: 15),
    is_read: [false, true].sample,
    is_favorited: [false, true].sample,
    book: cr,
    user: john
  )

cr = Book.create({
  title: "Le Miroir d'ambre",
  serie_number: 3,
  book_type: 'Roman',
  serie: croisee_serie,
  description: "Will décide de partir à la recherche de Lyra, qui est retenue prisonnière par sa mère Mme Coulter en Himalaya. Il rencontre au cours de son périple Iorek Byrnison avec qui il va chercher Lyra. Avec l'aide d'une fille de la région, Ama, ils arrachent Lyra des griffes de Mme Coulter, pour ensuite entamer un voyage au royaume des morts. Ils découpent une fenêtre dans ce monde, pour laisser les fantômes des morts s'échapper et faire de nouveau corps avec la nature. ",
  author: 'Philip Pullman',
  release: Date.new(2001),
  edition: 'Gallimard'
})
cr.cover_img.attach(io: File.open("app/assets/images/croisee3.jpg"), filename: 'croisee3', content_type: "image/jpg")
cr.save!

Collection.create(
    comment: Faker::Lorem.sentence(word_count: 15),
    is_read: [false, true].sample,
    is_favorited: [false, true].sample,
    book: cr,
    user: john
  )

puts 'Done'
