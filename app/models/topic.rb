class Topic < ApplicationRecord

  include Redis::Objects
  include MarkdownBody
  include SoftDelete

  belongs_to :user, inverse_of: :topics
  belongs_to :node, inverse_of: :topics

  validates :user_id, :title, :body, presence: true

  # 不获取分类为'private'的文章
  scope :without_private, -> { joins(:node).where("nodes.name != 'private'") }

  # 阅读量
  counter :hits, default: 0

  before_create :init_last_active_mark_on_create
  def init_last_active_mark_on_create
    self.last_active_mark = Time.now.to_i
  end

end
