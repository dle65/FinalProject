class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.text :color
      t.string :size
      t.integer :price

      t.timestamps
    end
  end
end
