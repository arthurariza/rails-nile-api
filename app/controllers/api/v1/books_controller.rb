# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApplicationController
      def index
        books = Book.includes(:author)

        render json: { Books: BooksSerializer.new(books).to_json }
      end

      def create
        author = Author.create!(author_params)
        book = author.books.new(book_params)

        if book.save
          render json: BookSerializer.new(book).to_json, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def destroy
        Book.find(params[:id]).destroy!

        head :no_content
      end

      private

      def author_params
        params.require(:author).permit(:first_name, :last_name, :age)
      end

      def book_params
        params.require(:book).permit(:title)
      end
    end
  end
end
