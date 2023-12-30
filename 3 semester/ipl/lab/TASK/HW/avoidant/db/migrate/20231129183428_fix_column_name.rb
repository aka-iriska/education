class FixColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :search_requests, :floor, :gender
  end
end
