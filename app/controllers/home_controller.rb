class HomeController < ApplicationController

  def index
    # 只获取所有可见的文章信息
    node_ids = Node.where(publish: true).pluck(:id)

    @last_created_topics = Topic.includes(:node).where("node_id in (:node_ids)", node_ids: node_ids)
                            .order('created_at DESC').limit(10)

    @last_updated_topics = Topic.includes(:node).where("node_id in (:node_ids)", node_ids: node_ids)
                            .order('updated_at DESC').limit(10)
  end

end
