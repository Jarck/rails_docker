require 'rails_helper'

RSpec.describe API::V1::Pictures, type: :request do

  describe 'GET /api/v1/pictures.json' do

    context 'without login user' do
      it 'is return status 200 OK' do
        get '/api/v1/pictures.json'

        expect(response.status).to eq(401)
      end
    end

    context 'with login user' do
      it 'return pictures list' do
        login_user!
        get '/api/v1/pictures.json'

        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST /api/v1/pictures.json' do
    it 'without login user' do
      post '/api/v1/pictures.json', image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'factories', 'jarck.png'), 'image/png')

      expect(response.status).to eq(401)
      expect(json['error']).to eq('Access Token 无效')
    end

    it 'with login user' do
      login_user!
      post '/api/v1/pictures.json', image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'factories', 'jarck.png'), 'image/png')

      expect(response.status).to eq(201)
    end
  end

  describe 'DELETE /api/v1/pictures/:id.json' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:picture) { FactoryGirl.create(:picture, image: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'factories', 'jarck.png'), 'image/png')], user: user) }
    let!(:picture_cur) { FactoryGirl.create(:picture, image: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'factories', 'jarck.png'), 'image/png')], user: current_user) }

    it 'without login user' do
      delete "/api/v1/pictures/#{picture.id}.json"

      expect(response.status).to eq(401)
    end

    context 'with login user' do
      it 'picture not found' do
        login_user!
        delete '/api/v1/pictures/xxx.json'

        expect(response.status).to eq(404)
      end

      it 'unupload picture' do
        login_user!
        delete "/api/v1/pictures/#{picture.id}"

        expect(response.status).to eq(403)
        expect(json['error']).to eq('没有权限删除图片！')
      end

      it 'create unupload picture' do
        login_user!
        delete "/api/v1/pictures/#{picture_cur.id}"

        expect(response.status).to eq(200)
      end
    end
  end

end