class TopicDetailSerializer < TopicSerializer
  attributes :body, :body_html, :hits

  belongs_to :node
  belongs_to :user

  def hits
    object.hits.to_i
  end
end
