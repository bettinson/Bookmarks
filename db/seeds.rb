# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

5.times do 
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password: BCrypt::Password.create('secret'))
end

User.all.each do |u|
  tags = []
  Random.rand(11).times do
    Random.rand(3).times do
      tags << Faker::Hacker.adjective
    end

    bookmark = Bookmark.new(url: Faker::Internet.url, description: Faker::Hipster.sentences(1), user_id: u.id)

    unless tags.nil? || tags.empty?
      tags.each do |t|
        tag = Tag.where(name: t).first_or_initialize
        bookmark.tags.append tag
        tag.save
      end
    end
    bookmark.save
  end
end

User.create(name: "Matt Bettinson", email: "mattbettinson@gmail.com", password: BCrypt::Password.create('password'))