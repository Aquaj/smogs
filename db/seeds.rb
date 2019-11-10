# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts "== Seeding..."

story = Story.create!(name: 'TestStory', slug: 'test')
beginning = Arc.create!(name: "The Beginning", slug: 'beginning', story: story, position: 1)
following = Arc.create!(name: "The Following", slug: 'following', story: story, position: 2)

pub_begin  = Publication.create!(published_at: DateTime.now - 2.day, arc: beginning)
pub_follow = Publication.create!(published_at: DateTime.now - 1.day, arc: following)

Page.new(title: 'it', content: 'me', publication: pub_begin, publication_order: 2).tap { |p|
  p.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'comic-example.png')),
                 filename: 'Example')
}.save!

Page.new(title: 'hello',
             content: 'is',
             publication: pub_begin,
             publication_order: 1).tap { |p|
  p.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'comic-example.png')),
                 filename: 'Example')
}.save!

Page.new(title: 'looking',
             content: 'for?',
             publication: pub_follow,
             publication_order: 2).tap { |p|
  p.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'comic-example.png')),
                 filename: 'Example')
}.save!
Page.new(title: 'me',
             content: 'you\'re',
             publication: pub_follow,
             publication_order: 1).tap { |p|
  p.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'comic-example.png')),
                 filename: 'Example')
}.save!

Page.new(title: 'Toto', content: 'Test').tap { |p|
  p.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'comic-example.png')),
                 filename: 'Example')
}.save!


puts "== Seeding complete !"
