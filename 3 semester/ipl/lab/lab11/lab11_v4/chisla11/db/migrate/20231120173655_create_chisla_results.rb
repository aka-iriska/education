class CreateChislaResults < ActiveRecord::Migration[7.0]
  def change
    create_table :chisla_results do |t|
      t.text :string
      t.text :result
      t.json :my_table

      t.timestamps
    end
    add_index :chisla_results, :string, unique: true
  end
end
