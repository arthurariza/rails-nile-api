# frozen_string_literal: true

class BooksSerializer
  def initialize(books)
    @books = books
  end

  def to_json(*_args)
    books.map do |book|
      {
        id: book.id,
        title: book.title,
        author_name: author_name(book),
        author_age: book.author.age
      }
    end
  end

  private

  attr_reader :books

  def author_name(book)
    "#{book.author.first_name} #{book.author.last_name}"
  end
end
