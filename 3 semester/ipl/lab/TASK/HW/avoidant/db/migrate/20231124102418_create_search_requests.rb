class CreateSearchRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :search_requests do |t|
      t.string :address
      t.string :conditions
      t.string :floor
      t.integer :age
      t.string :body_type
      t.float :height
      t.string :race
      t.boolean :facial_hair
      t.string :voice
      t.string :hair_color
      t.string :ears
      t.boolean :wrinkles

      t.timestamps
    end
  end
end
