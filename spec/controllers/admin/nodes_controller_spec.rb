require 'rails_helper'

RSpec.describe Admin::NodesController, type: :controller do
  let!(:member) { FactoryBot.create(:member) }
  let(:admin) { FactoryBot.create(:admin) }
  let(:user_admin) { FactoryBot.create(:user) }
  let(:member) { FactoryBot.create(:member) }
  let(:user_member) { FactoryBot.create(:user) }
  let(:node) { FactoryBot.create(:node) }

  describe 'GET #index' do
    context 'unsign in' do
      it 'is not allow to index action with unsign in' do
        expect { get :index }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'sign in' do
      it 'is allow to index action with sign in as admin' do
        user_admin.add_role :admin
        sign_in user_admin
        get :index

        expect(response).to be_successful
        expect(response).to have_http_status(200)
        expect(response).to render_template('index')
      end

      it 'is not allow to index action with sign in as member' do
        user_member.add_role :member
        sign_in user_member
        expect { get :index }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'GET #new' do
    context 'unsign in' do
      it 'is not allow to new with unsign in' do
        expect { get :new }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'sign in' do
      it 'is allow to new with sign in as admin' do
        user_admin.add_role :admin
        sign_in user_admin
        get :new

        expect(response).to be_successful
      end

      it 'is not allow to new with sign in as member' do
        user_member.add_role :member
        sign_in user_member
        expect { get :new }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'GET #edit' do
    context 'unsign in' do
      it 'is not allow to edit with unsign in' do
        expect { get :edit, params: { id: node.id } }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'sign in' do
      it 'is allow to edit with sign in as admin' do
        user_admin.add_role :admin
        sign_in user_admin
        get :edit, params: { id: node.id }

        expect(response).to be_successful
      end

      it 'is not allow to edit with sign in as member' do
        user_member.add_role :member
        sign_in user_member
        expect { get :edit, params: { id: node.id } }.to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
