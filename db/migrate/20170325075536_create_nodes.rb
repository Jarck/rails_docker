class CreateNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :nodes do |t|
      t.string :name,                     comment: '英文名'
      t.string :title,                    comment: '显示名称'
      t.boolean :publish, default: false, comment: '是否公开，默认false'

      t.timestamps
    end
  end
end
