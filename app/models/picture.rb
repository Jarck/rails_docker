class Picture < ApplicationRecord
  validates_presence_of :image

  belongs_to :user

  # 图片
  mount_uploaders :image, AvatarUploader

  # # 删除时同时删除上传文件
  # after_destroy :delete_picture_file
  # def delete_picture_file
  #   FileUtils.remove_dir("#{Rails.root}/public/uploads/#{self.id}", :force => true) if self.image
  # end

end
