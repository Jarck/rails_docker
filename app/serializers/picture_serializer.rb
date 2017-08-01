class PictureSerializer < BaseSerializer
  attributes :id, :image

  belongs_to :user

end
