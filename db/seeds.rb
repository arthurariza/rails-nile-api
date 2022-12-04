# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

one = Author.create!(first_name: :Author, last_name: :One, age: 20)
two = Author.create!(first_name: :Author, last_name: :Two, age: 21)
three = Author.create!(first_name: :Author, last_name: :Three, age: 22)

one.books.create!(title: 'Book One')
one.books.create!(title: 'Book Two')
two.books.create!(title: 'Book Three')
two.books.create!(title: 'Book Four')
three.books.create!(title: 'Book Five')
three.books.create!(title: 'Book Six')
