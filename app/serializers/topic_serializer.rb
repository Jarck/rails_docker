class TopicSerializer < BaseSerializer
  attributes :id, :title, :body, :body_html, :hits, :created_at, :updated_at,
             :node, :user,
             :deleted

  belongs_to :node
  belongs_to :user

  def hits
    object.hits.to_i
  end

  def deleted
    !object.deleted_at.nil?
  end

end
