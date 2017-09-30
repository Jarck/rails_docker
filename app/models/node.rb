class Node < ApplicationRecord
  extend FriendlyId

  has_many :topics

  friendly_id :name, use: :slugged

  validates :name, :title, :publish, presence: true

  enum publish: { visible: 1, invisible: 0 }
end
