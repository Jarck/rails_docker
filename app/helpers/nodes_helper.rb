module NodesHelper
  def publish_select
    publish = []
    publish << %w[不可见 invisible]
    publish << %w[可见 visible]
    publish
  end
end
