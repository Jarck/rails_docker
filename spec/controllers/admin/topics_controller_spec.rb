require 'rails_helper'

RSpec.describe Admin::TopicsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:node) { FactoryGirl.create(:node) }
  let(:topic) { FactoryGirl.create(:topic, user: user, node: node) }

  describe "GET #index" do
    context 'unsign in' do
      it 'is not allow to index action with unsign in' do
        expect{get :index}.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'sign in' do
      it 'is allow to index action with sign in' do
        sign_in user
        get :index

        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(response).to render_template('index')
      end
    end
  end

  describe "GET #new" do
    context 'unsign in' do
      it 'is not allow to new with unsign in' do
        expect{get :new}.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'sign in' do
      it 'is allow to new with sign in' do
        sign_in user
        get :new

        expect(response).to be_success
      end
    end
  end

  describe "GET #edit" do
    context "unsign in" do
      it 'is not allow to edit with unsign in' do
        expect{get :edit, params: {id: topic.id}}.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'sign in' do
      it 'is allow to edit with sign in' do
        sign_in user
        get :edit, params: {id: topic.id}

        expect(response).to be_success
      end
    end
  end

  describe "GET #show" do
    context "unsign in" do
      it 'is not allow to show with unsign in' do
        expect{get :show, params: {id: topic.id}}.to raise_error(CanCan::AccessDenied)
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

  describe "PATCH #update" do
    let(:valid_topic_attribute) { FactoryGirl.attributes_for(:topic, title: 'test update') }

    context "unsign in" do
      it 'is not allow to update with unsign in' do
        expect{ patch :update, params: {id: topic.id, topic: valid_topic_attribute}}.to raise_error(CanCan::AccessDenied)
      end
    end

    context "sign in" do
      it 'is allow to update with sign in' do
        sign_in user

        patch :update, params: {id: topic.id, topic: valid_topic_attribute}
        topic.reload

        expect(topic.title).to eq('test update')
      end
    end
  end

  describe "POST #create" do

    let(:valid_topic_attribute) { FactoryGirl.attributes_for(:topic, user_id: user, node_id: node) }

    context "unsign in" do
      it 'is not allow to create with unsign in' do
        expect{ post :create, params: {topic: valid_topic_attribute}}.to raise_error(CanCan::AccessDenied)
      end
    end

    context "sign in" do
      it 'is allow to create with sign in' do
        sign_in user
        expect{ post :create, params: {topic: valid_topic_attribute}}.to change(Topic, :count).by(1)
      end
    end
  end

  describe "DELETE #destroy" do
    context "unsign in" do
      it 'is allow to destroy with unsign in' do
        expect{delete :destroy, params: {id: topic.id}}.to raise_error(CanCan::AccessDenied)
      end
    end

    context "sign in" do
      it 'is allow to destroy with sign in' do
        sign_in user
        delete :destroy, params: {id: topic.id}

        expect(response).to redirect_to(admin_topics_path)
      end
    end
  end

end