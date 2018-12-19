class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, limit: 199, null: false
      t.text :description
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
