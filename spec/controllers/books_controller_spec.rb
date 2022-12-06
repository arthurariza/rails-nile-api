require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  it 'has a max pagination limit of 100' do
    expect(Book).to receive(:limit).with(100).and_call_original

    get :index, params: { limit: 999 }
  end

  context 'POST create' do
    it 'calls the job when the model is valid' do
      expect(UpdateSkuJob).to receive(:perform_later).with('Harry Potter One')

      post :create, params: {
        book: {
          'title' => 'Harry Potter One'
        },
        author: {
          'first_name' => 'JK',
          'last_name' => 'Rowling',
          'age' => 50
        }
      }
    end

    it 'does not calls the job when the model is invalid' do
      expect(UpdateSkuJob).not_to receive(:perform_later)

      post :create, params: {
        book: {
          'title' => ''
        },
        author: {
          'first_name' => 'JK',
          'last_name' => 'Rowling',
          'age' => 50
        }
      }
    end
  end
end
