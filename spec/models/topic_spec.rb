require 'rails_helper'

RSpec.describe Topic, type: :model do

  describe 'data valiad' do
    it 'is valid with user_id, title and body' do
      topic = FactoryGirl.build(:topic)

      expect(topic).to be_valid
    end

    it 'is invalid without user_id' do
      topic = FactoryGirl.build(:topic, user_id: nil)

      expect(topic).not_to be_valid
      expect(topic).to have(1).error_on(:user_id)
    end

    it 'is invalid without title' do
      topic = FactoryGirl.build(:topic, title: nil)

      expect(topic).not_to be_valid
      expect(topic).to have(1).error_on(:title)
    end

    it 'is invalid without body' do
      topic = FactoryGirl.build(:topic, body: nil)

      expect(topic).not_to be_valid
      expect(topic).to have(1).error_on(:body)
    end
  end

  describe 'convert body on save' do
    it 'is convert with text' do
      topic = FactoryGirl.create(:text_body)

      expect(topic.body_html.gsub(/\n/, '')).to eq('<p>test</p>')
    end

    it 'is convert with valid html' do
      topic = FactoryGirl.create(:valid_html_body)

      expect(topic.body_html.gsub(/\n/, '')).to eq('<p>test</p>')
    end

    it 'is convert with invalid html tag' do
      topic = FactoryGirl.create(:invalid_html_body)

      expect(topic.body_html.gsub(/\n/, '')).to eq('alert("test");')
    end

    it 'is not convert when body not changed' do
      topic = FactoryGirl.create(:text_body)

      topic.body = 'test test'
      allow(topic).to receive(:body_changed?).and_return(false)

      old_body_html = topic.body_html
      topic.save

      expect(topic.body_html).to eq(old_body_html)
    end

  end

end