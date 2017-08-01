class TopicsController < ApplicationController

  def index
    # 只获取所有可见的文章信息
    node_ids = Node.where(publish: true).pluck(:id)

    @topics = Topic.includes(:node).where("node_id in (:node_ids)", node_ids: node_ids).paginate(page: params[:page], :per_page => 10).order('created_at DESC')
  end

  def show
    @threads = []

    @topic = Topic.unscoped.includes(:user).find(params[:id])

    # 阅读量自动加1
    @threads << Thread.new do
      @topic.hits.incr(1)
    end

    @threads.each(&:join)

    render_404 if @topic.deleted?
  end

end