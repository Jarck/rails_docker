class NodesController < ApplicationController

  def show
    node_id = params[:id]

    @topics = Node.friendly.find(node_id).topics.paginate(page: params[:page], :per_page => 10).order('created_at DESC')
    render '/topics/index'
  end

end
