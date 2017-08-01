require 'rails_helper'

RSpec.describe API::V1::Topics, type: :request do

  let(:user) { FactoryGirl.create(:user) }
  let(:node) { FactoryGirl.create(:node) }
  let(:node_private) { FactoryGirl.create(:private) }

  describe 'GET /api/v1/topics.json' do
    let!(:topic) { FactoryGirl.create(:topic, user: user, node: node) }
    let!(:topic_private) { FactoryGirl.create(:topic, user: user, node: node_private) }

    context 'without login user' do
      it 'is return status 200 OK' do
        get '/api/v1/topics.json'

        expect(response.status).to eq(200)
      end

      it 'return topics without private node' do
        get '/api/v1/topics.json'

        topics = [topic, topic_private]

        expect(response.status).to eq(200)
        expect(json.size).to eq(1)
      end
    end

    context 'with login user' do
      it 'return topics without private node' do
        login_user!
        get '/api/v1/topics.json'

        expect(response.status).to eq(200)
        expect(json.size).to eq(1)
      end
    end
  end

  describe 'GET /api/v1/topics.json with node id' do
    let!(:topic1) { FactoryGirl.create(:topic, user: user, node: node) }
    let!(:topic2) { FactoryGirl.create(:topic, user: user, node: node) }
    let!(:topic3) { FactoryGirl.create(:topic, user: user, node: node) }
    let!(:topic_private) { FactoryGirl.create(:topic, user: user, node: node_private) }

    context 'is return a list of topics belong to the appoint node' do
      it 'with wrong node_id' do
        get '/api/v1/topics.json', node_id: -1

        expect(response.status).to eq(404)
      end

      it 'with right node_id' do
        get '/api/v1/topics.json', node_id: node.id

        expect(response.status).to eq(200)
        expect(json.size).to eq(3)
      end

      it 'with right node_id, offset, limit' do
        get '/api/v1/topics.json', node_id: node.id, offset: 1, limit: 1

        expect(response.status).to eq(200)
        expect(json.size).to eq(1)
      end

      it 'with wrong limit' do
        get '/api/v1/topics.json', node_id: node.id, offset: 1, limit: 10000

        expect(response.status).to eq(400)
      end
    end
  end

  describe 'POST /api/v1/topics.json' do
    it 'without login user' do
      post '/api/v1/topics.json', title: 'title', body: 'body', node_id: node.id

      expect(response.status).to eq(401)
    end

    it 'with login user' do
      login_user!
      post '/api/v1/topics.json', title: 'title', body: 'body', node_id: node.id

      expect(response.status).to eq(201)
      expect(json['title']).to eq('title')
      expect(json['body']).to  eq('body')
    end
  end

  describe 'POST /api/v1/topics/:id.json' do
    let!(:topic) { FactoryGirl.create(:topic, user: user, node: node) }
    let!(:topic_cur) { FactoryGirl.create(:topic, user: current_user, node: node) }

    it 'without login user' do
      post "/api/v1/topics/#{topic.id}.json", title: 'title update', body: 'body update', node_id: node.id

      expect(response.status).to eq(401)
      expect(json['error']).to eq('Access Token 无效')
    end

    it 'with login user which create the update topic' do
      login_user!
      post "/api/v1/topics/#{topic_cur.id}.json", title: 'title update', body: 'body update', node_id: node.id

      expect(response.status).to eq(201)
      expect(json['title']).to eq('title update')
      expect(json['body']).to  eq('body update')
    end

    it 'with login user which uncreate the update topic' do
      login_user!
      post "/api/v1/topics/#{topic.id}.json", title: 'title update', body: 'body update', node_id: node.id

      expect(response.status).to eq(403)
      expect(json['error']).to eq('没有权限修改文章！')
    end

    it 'with login admin which uncreate the update topic' do
      login_admin!
      post "/api/v1/topics/#{topic.id}.json", title: 'title update', body: 'body update', node_id: node.id

      expect(response.status).to eq(201)
      expect(json['title']).to eq('title update')
      expect(json['body']).to  eq('body update')
    end
  end

  describe 'GET /api/v1/topics/:id.json' do
    let!(:topic) { FactoryGirl.create(:topic, user: user, node: node) }

    it 'hits count plus 1' do
      last_hits = topic.hits.to_i
      get "/api/v1/topics/#{topic.id}.json"

      expect(response.status).to eq(200)
      expect(json['hits'].to_i).to eq(last_hits + 1)
    end
  end

  describe 'DELETE /api/v1/topics/:id.json' do
    let!(:topic) { FactoryGirl.create(:topic, user: user, node: node) }
    let!(:topic_cur) { FactoryGirl.create(:topic, user: current_user, node: node) }

    it 'without login user' do
      delete "/api/v1/topics/#{topic.id}.json"

      expect(response.status).to eq(401)
    end

    context 'with login user' do
      it 'topic not found' do
        login_user!
        delete '/api/v1/topics/xxx.json'

        expect(response.status).to eq(404)
      end

      it 'uncreate topic' do
        login_user!
        delete "/api/v1/topics/#{topic.id}"

        expect(response.status).to eq(403)
        expect(json['error']).to eq('没有权限删除文章！')
      end

      it 'create topic' do
        login_user!
        delete "/api/v1/topics/#{topic_cur.id}"

        expect(response.status).to eq(200)
        topic_cur.reload
        expect(topic_cur.deleted?).to eq(true)
      end

      it 'role login admin which uncreate the update topic' do
        login_admin!
        delete "/api/v1/topics/#{topic.id}.json"

        expect(response.status).to eq(200)
        topic.reload
        expect(topic.deleted?).to eq(true)
      end
    end
  end

end