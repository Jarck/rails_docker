require 'rails_helper'

RSpec.describe API::V1::Root, type: :request do
  let(:json) { JSON.parse(response.body) }

  describe 'Not found routes' do
    it 'is return status 404' do
      get '/api/v1/test.json'

      expect(response.status).to eq(404)
      expect(json['error']).to eq('Page not found.')
    end
  end

  describe 'GET /api/v1/hello.json' do
    context 'without oauth 2.0' do
      it 'is faild with 401' do
        get '/api/v1/hello.json'

        expect(response.status).to eq(401)
        expect(json['error']).to eq('Access Token 无效')
      end
    end

    context 'with oauth 2.0' do
      it 'is return 200 OK' do
        login_user!
        get '/api/v1/hello.json'

        expect(response.status).to eq(200)
        expect(json['user']['id']).to eq(current_user.id)
      end
    end
  end

end