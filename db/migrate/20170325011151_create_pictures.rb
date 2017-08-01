class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.integer :user_id, null: false, comment: '上传者id'
      t.json    :image,   null: false, comment: 'avatar'

      t.timestamps
    end

    add_index(:pictures, :user_id)
  end
end
