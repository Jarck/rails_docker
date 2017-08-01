class Node < ApplicationRecord
  extend FriendlyId

  has_many :topics

  friendly_id :name, use: :slugged
end
