module API
  module V1

    # 文章
    class Topics < Grape::API
      format :json

      resources :topics do

        desc '获取文章列表'
        params do
          optional :node_id, type: Integer, desc: '如果只看某一分类的文章，请传入该参数'
          optional :offset,  type: Integer, default: 0
          optional :limit,   type: Integer, default: 20, values: 1..100
        end
        get '', each_serializer: TopicSerializer, root: 'topics' do
          if params[:node_id].blank?
            @topics = Topic
          else
            node = Node.includes(:topics).find(params[:node_id])
            @topics = node.topics
          end

          @topics = @topics.includes(:user, :node).without_private.offset(params[:offset]).limit(params[:limit])

          render @topics
        end

        desc '创建文章'
        params do
          requires :title,   type: String, desc: '标题'
          requires :body,    type: String, desc: '文章内容，Markdown格式'
          requires :node_id, type: String, desc: '文章分类'
        end
        post '', serializer: TopicDetailSerializer, root: 'topic' do
          doorkeeper_authorize!
          error!('没有权限创建文章！', 403) unless can?(:create, Topic)
          @topic = current_user.topics.new(title: params[:title], body: params[:body])
          @topic.node_id = params[:node_id]

          if @topic.save
            render @topic
          else
            error!( {result: false, error: @topic.errors.full_messages}, 400 )
          end
        end

        namespace ':id' do
          desc '更新文章'
          params do
            requires :title,   type: String, desc: '标题'
            requires :body,    type: String, desc: '文章内容，Markdown格式'
            requires :node_id, type: String, desc: '文章分类'
          end
          post '', serializer: TopicDetailSerializer, root: 'topic' do
            doorkeeper_authorize!
            @topic = Topic.find(params[:id])
            error!('没有权限修改文章！', 403) unless can?(:update, @topic)

            @topic.title   = params[:title]
            @topic.body    = params[:body]
            @topic.node_id = params[:node_id]

            if @topic.save
              render @topic
            else
              error!( {result: false, error: @topic.errors.full_messages}, 400 )
            end
          end

          desc '获取文章'
          get '', serializer: TopicDetailSerializer, root: 'topic' do
            if current_user
              @topic = Topic.find(params[:id])
            else
              @topic = Topic.without_private.find(params[:id])
            end
            @topic.hits.incr(1)

            render @topic
          end

          desc '删除文章'
          delete '' do
            doorkeeper_authorize!
            @topic = Topic.find(params[:id])
            error!('没有权限删除文章！', 403) unless can?(:destroy, @topic)
            @topic.destroy

            { result: true, message: '删除成功！' }
          end
        end

      end  # resources end
    end    # class end

  end      # module v1 end
end        # module API end
