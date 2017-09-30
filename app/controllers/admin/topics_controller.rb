class Admin::TopicsController < ApplicationController
  load_and_authorize_resource

  before_action :options_select, only: %i[new edit create update]

  def index
    @topics = @topics.paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end

  def show
    render_404 if @topic.deleted?
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id

    if @topic.save
      redirect_to(admin_topic_path(@topic), notice: I18n.t('common.create_success'))
    else
      render action: 'new'
    end
  end

  def update
    if @topic.update_attributes(topic_params)
      redirect_to(admin_topic_path(@topic), notice: I18n.t('common.update_success'))
    else
      render action: 'edit'
    end
  end

  def destroy
    @topic.destroy
    redirect_to(admin_topics_path, notice: t('common.delete_success'))
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body, :node_id)
  end

  def options_select
    @nodes_select = Node.all.collect { |node| [node.name, node.id] }
  end
end
