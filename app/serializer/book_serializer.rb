# frozen_string_literal: true

class BookSerializer
  def initialize(book)
    @book = book
  end

  def to_json(*_args)
    {
      id: book.id,
      title: book.title,
      author_name: author_name(book),
      author_age: book.author.age
    }
  end

  private

  attr_reader :book

  def author_name(book)
    "#{book.author.first_name} #{book.author.last_name}"
  end
end
