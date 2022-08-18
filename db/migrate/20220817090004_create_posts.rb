class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :grade_id, null: false
      t.text :mother_board
      t.text :cpu, null: false
      t.text :memory, null: false
      t.text :storage, null: false
      t.text :graphic_board, null: false
      t.text :case
      t.text :case_fan
      t.text :power
      t.text :compatibility
      t.text :description
      t.timestamps
    end
  end
end
