module API
  module V1

    # 图片
    class Pictures < Grape::API
      format :json

      resources :pictures do

        desc '获取上传图片列表'
        params do
          optional :offset, type: Integer, default: 0
          optional :limit,  type: Integer, default: 20, values: 1..100
        end
        get '', each_serializer: PictureSerializer, root: 'pictures' do
          doorkeeper_authorize!
          @pictures = current_user.pictures.offset(params[:offset]).limit(params[:limit])

          render @pictures
        end

        desc '上传图片'
        params do
          requires :image, desc: '图片'
        end
        post '', serializer: PictureSerializer do
          doorkeeper_authorize!
          error!('没有权限上传图片！', 403) unless can?(:create, Picture)
          @picture = current_user.pictures.new
          @picture.image = [ params[:image] ]

          if @picture.save
            render @picture
          else
            error!( {result: false, error: @picture.errors.full_messages}, 400 )
          end
        end

        desc '删除图片'
        delete ':id' do
          doorkeeper_authorize!
          @picture = Picture.find(params[:id])
          error!('没有权限删除图片！', 403) unless can?(:update, @picture)

          if @picture.destroy
            { result: true, message: '删除成功！' }
          else
            error!( {result: false, error: @picture.errors.full_messages}, 400 )
          end
        end

      end  # resources end
    end    # class end

  end      # module V1 end
end        # module API end
