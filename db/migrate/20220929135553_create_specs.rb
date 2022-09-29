class CreateSpecs < ActiveRecord::Migration[6.1]
  def change
    create_table :specs do |t|
      
      t.string :name, null: false
      
      t.timestamps
    end
  end
end
