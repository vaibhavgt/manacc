class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :user_id, null:false
      t.string :source
      t.text :description
      t.string :type
      t.timestamps null: false
    end
  end
end
