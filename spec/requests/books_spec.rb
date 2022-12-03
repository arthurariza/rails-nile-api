require 'rails_helper'

describe 'Books API', type: :request do
  it 'returns all the books' do
    FactoryBot.create(:book, title: '1984', author: 'George Orwel')
    FactoryBot.create(:book, title: 'The Time Machine', author: 'H.G. Wells')

    get '/api/v1/books'

    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body)['Books'].size).to eq(2)
  end
end
