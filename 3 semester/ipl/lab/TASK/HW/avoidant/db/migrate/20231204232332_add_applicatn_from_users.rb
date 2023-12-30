class AddApplicatnFromUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :finds, :users, index: true, foreign_key: true
  end
end
