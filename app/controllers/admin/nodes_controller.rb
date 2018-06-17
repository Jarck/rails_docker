class Admin::NodesController < ApplicationController
  before_action :find_node, only: %i[show edit update destroy]
  load_and_authorize_resource

  def index
    @nodes = @nodes.paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end

  def show
    render_404 if @node.deleted?
  end

  def create
    @node = Node.new(node_params)

    if @node.save
      redirect_to(admin_nodes_path, notice: I18n.t('common.create_success'))
    else
      render action: 'new'
    end
  end

  def update
    if @node.update_attributes(node_params)
      redirect_to(admin_nodes_path, notice: I18n.t('common.update_success'))
    else
      render action: 'edit'
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      topics = @node.topics
      private_node = Node.find_by(name: 'private')
      topics.update_attributes!(node_id: private_node) if topics.present? && private_node.present?

      @node.destroy!
      redirect_to(admin_nodes_path, notice: t('common.delete_success'))
    end
  end

  private

  def node_params
    params.require(:node).permit(:name, :title, :publish)
  end

  def find_node
    @node = Node.friendly.find(params[:id])
  end
end
