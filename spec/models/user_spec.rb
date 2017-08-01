require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'roles' do

    context 'when with new user' do
      it 'has role with member' do
        user = FactoryGirl.build(:user)
        user.save

        expect(user).to have_role(:member)
      end
    end

    context 'assign role as admin' do
      it 'assign role with admin' do
        user = FactoryGirl.build(:user)
        user.save

        user.add_role(:admin)

        expect(user).to have_role(:admin)
      end
    end

  end

  describe 'login both with name, email' do
    let!(:user) { FactoryGirl.create(:user, name: 'test', email: 'test@test.com') }

    it 'login with user name' do
      expect(User.find_for_database_authentication(login: 'test').id).to eq user.id
    end

    it 'login with user email' do
      expect(User.find_for_database_authentication(login: 'test@test.com').id).to eq user.id
    end

    it 'login with unknown user info ' do
      expect(User.find_for_database_authentication(login: 'not found')).to eq nil
    end
  end

end
