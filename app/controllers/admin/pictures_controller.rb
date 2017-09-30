class Admin::PicturesController < ApplicationController
  load_and_authorize_resource

  def index
    @pictures = @pictures.paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end

  def create
    # 将上传的多张图片分别保存到一条记录中
    save_images = []
    params[:picture][:image].each do |i|
      image_info = { image: [i], user_id: current_user.id }
      save_images << image_info
    end

    if Picture.create(save_images)
      redirect_to(admin_pictures_path, notice: I18n.t('common.create_success'))
    else
      render action: 'new'
    end
  end

  def destroy
    @picture.destroy
    redirect_to(admin_pictures_path, notice: t('common.delete_success'))
  end

  private

  def picture_params
    params.require(:picture).permit(image: [])
  end
end
