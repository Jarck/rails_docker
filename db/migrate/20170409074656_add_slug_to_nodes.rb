class AddSlugToNodes < ActiveRecord::Migration[5.0]
  def change
    add_column :nodes, :slug, :string
    add_index  :nodes, :slug, unique: true
  end
end
