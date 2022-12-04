# frozen_string_literal: true

require 'rails_helper'

describe 'Books API', type: :request do
  let(:author) { FactoryBot.create(:author) }

  describe 'GET /books' do
    it 'returns all the books' do
      FactoryBot.create(:book, title: '1984', author:)
      FactoryBot.create(:book, title: 'The Time Machine', author:)

      get '/api/v1/books'

      resp_body = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(resp_body['Books'].size).to eq(2)
      expect(resp_body['Books']).to eq([
                                         {
                                           'id' => 1,
                                           'title' => '1984',
                                           'author_name' => 'Author One',
                                           'author_age' => 25
                                         },
                                         {
                                           'id' => 2,
                                           'title' => 'The Time Machine',
                                           'author_name' => 'Author One',
                                           'author_age' => 25
                                         }
                                       ])
    end
  end

  describe 'POST /books' do
    let(:author) { { first_name: 'George', last_name: 'Orwel', age: 50 } }

    it 'creates a new book' do
      book = { title: '1984' }

      expect do
        post '/api/v1/books', params: { book:, author: }
      end.to change { Book.count }.from(0).to(1)

      resp_body = JSON.parse(response.body)

      expect(response).to have_http_status(:created)
      expect(Author.count).to eq(1)
      expect(resp_body).to eq(
        {
          'id' => 1,
          'title' => '1984',
          'author_name' => 'George Orwel',
          'author_age' => 50
        }
      )
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
