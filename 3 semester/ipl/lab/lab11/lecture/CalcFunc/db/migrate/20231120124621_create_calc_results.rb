class CreateCalcResults < ActiveRecord::Migration[7.0]
  def change
    create_table :calc_results do |t|
      t.float :from
      t.float :to
      t.float :step
      t.text :result

      t.timestamps
    end
  end
end
