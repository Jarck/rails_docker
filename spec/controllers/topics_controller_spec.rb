require 'rails_helper'

RSpec.describe TopicsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:topic) { FactoryGirl.create(:topic, user: user) }

  describe "GET #index" do
    it 'is have an index action' do
      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template('index')
    end
  end

  describe "GET #show" do
    context "unsign in" do
      it 'is allow to show with unsign in' do
        get :show, params: {id: topic.id}

        expect(response).to be_success
      end
    end

    context "sign in" do
      it 'is allow to show with sign in' do
        sign_in user
        get :show, params: {id: topic.id}

        expect(response).to be_success
      end
    end
  end

end