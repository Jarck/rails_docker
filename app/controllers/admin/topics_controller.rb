class Admin::TopicsController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user.has_role?(:admin)
      # 获取全部的文章
      @topics = Topic.includes(:node).paginate(page: params[:page], :per_page => 10).order('created_at DESC')
    else
      # 仅获取当前用户的文章
      user_id = current_user.id
      @topics = Topic.includes(:node).where("user_id in (:user_id)", user_id: user_id)
                  .paginate(page: params[:page], :per_page => 10).order('created_at DESC')
    end
  end

  def show
    @topic = Topic.includes(:user).find(params[:id])

    render_404 if @topic.deleted?
  end

  def new
    @nodes_select = Node.all.collect { |node| [node.name, node.id] }
    @topic = Topic.new
  end

  def edit
    @nodes_select = Node.all.collect { |node| [node.name, node.id] }
    @topic = Topic.find_by_id(params[:id])
  end

  def create
    @nodes_select = Node.all.collect { |node| [node.name, node.id] }
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id

    if @topic.save
      redirect_to(admin_topic_path(@topic), notice: I18n.t('common.create_success'))
    else
      render action: 'new'
    end
  end

  def update
    @topic = Topic.find(params[:id])

    if @topic.update_attributes(topic_params)
      redirect_to(admin_topic_path(@topic), notice: I18n.t('common.update_success'))
    else
      render action: 'edit'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to(admin_topics_path, notice: t('common.delete_success'))
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body, :node_id)
  end

end