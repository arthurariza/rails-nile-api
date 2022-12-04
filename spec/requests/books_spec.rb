# frozen_string_literal: true

require 'rails_helper'

describe 'Books API', type: :request do
  let(:author) { FactoryBot.create(:author) }

  describe 'GET /books' do
    it 'returns all the books' do
      FactoryBot.create(:book, title: '1984', author:)
      FactoryBot.create(:book, title: 'The Time Machine', author:)

      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['Books'].size).to eq(2)
    end
  end

  describe 'POST /books' do
    let(:author) { { first_name: 'George', last_name: 'Orwel', age: 50 } }

    it 'creates a new book' do
      book = { title: '1984' }

      expect do
        post '/api/v1/books', params: { book:, author: }
      end.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(Author.count).to eq(1)
    end

    it 'returns unprocessable_entity when validation fails' do
      book = { title: '', autor: 'Blank' }

      expect do
        post '/api/v1/books', params: { book:, author: }
      end.not_to change { Book.count }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE /books/:id' do
    it 'deletes a book' do
      book = FactoryBot.create(:book, title: '1984', author:)

      expect do
        delete "/api/v1/books/#{book.id}"
      end.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
