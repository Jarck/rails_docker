module NodesHelper
  def publish_select
    publish = []
    publish << ['不可见', 0]
    publish << ['可见', 1]
    publish
  end
end
