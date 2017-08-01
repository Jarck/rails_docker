require 'rails_helper'

RSpec.describe 'routing', type: :routing do

  describe 'routing' do
    it 'routes to root' do
      expect(get('/')).to route_to('home#index')
    end

    it 'routes to topics#index' do
      expect(get('/topics')).to route_to('topics#index')
    end

    it 'routes to topics#show' do
      expect(get('/topics/1')).to route_to('topics#show', id: '1')
    end

    it 'routes to nodes#show' do
      expect(get('/nodes/1')).to route_to('nodes#show', id: '1')
    end

    it 'routes to admin::topics#index' do
      expect(get('/admin/topics')).to route_to('admin/topics#index')
    end

    it 'routes to admin::topics#show' do
      expect(get('/admin/topics/1')).to route_to('admin/topics#show', id: '1')
    end

    it 'routes to admin::topics#new' do
      expect(get('/admin/topics/new')).to route_to('admin/topics#new')
    end

    it 'routes to admin::topics#edit' do
      expect(get('/admin/topics/1/edit')).to route_to('admin/topics#edit', id: '1')
    end

    it 'routes to admin::topics#create' do
      expect(post('/admin/topics')).to route_to('admin/topics#create')
    end

    it 'routes to admin::topics#destroy' do
      expect(delete('/admin/topics/1')).to route_to('admin/topics#destroy', id: '1')
    end
  end

end
