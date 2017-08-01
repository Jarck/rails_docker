class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.integer :user_id,         null: false, comment: '用户id'
      t.integer :node_id,         null: false, comment: '文章分类'
      t.string  :title,           null: false, comment: '文章标题'
      t.text    :body,            null: false, comment: '原始数据'
      t.text    :body_html,                    comment: 'Markdown格式数据'
      t.integer :last_active_mark

      t.datetime :deleted_at

      t.timestamps
    end

    add_index(:topics, :deleted_at)
    add_index(:topics, :last_active_mark)
    add_index(:topics, :user_id)
    add_index(:topics, :node_id)
  end
end
