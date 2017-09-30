class Admin::NodesController < ApplicationController
  load_and_authorize_resource

  def index
    @nodes = @nodes.paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end

  def show
    render_404 if @node.deleted?
  end

  def create
    @node = Node.new(node_params)
    @node.user_id = current_user.id

    if @node.save
      redirect_to(admin_node_path(@node), notice: I18n.t('common.create_success'))
    else
      render action: 'new'
    end
  end

  def update
    if @node.update_attributes(node_params)
      redirect_to(admin_node_path(@node), notice: I18n.t('common.update_success'))
    else
      render action: 'edit'
    end
  end

  def destroy
    @node.destroy
    redirect_to(admin_nodes_path, notice: t('common.delete_success'))
  end

  private

  def node_params
    params.require(:node).permit(:name, :title, :publish)
  end
end
