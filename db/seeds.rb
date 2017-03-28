# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# db/seeds.rb
require "open-uri"
require "yaml"

file = "https://gist.githubusercontent.com/ssaunier/25920c896baa0e4495fd/raw/9c26ce104c15fc237126bf6b136b8e318368f8ad/imdb.yml"
sample = YAML.load(open(file).read)

directors = {}  # slug => Director
sample["directors"].each do |director|
  directors[director["slug"]] = Director.create! director.slice("first_name", "last_name")
end

sample["movies"].each do |movie|
  director = directors[movie["director_slug"]]
  Movie.create! movie.slice("title", "year", "syllabus").merge(director: director)
end

sample["series"].each do |serie|
  Serie.create! serie
end
