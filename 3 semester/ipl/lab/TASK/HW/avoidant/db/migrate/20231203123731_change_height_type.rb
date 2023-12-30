class ChangeHeightType < ActiveRecord::Migration[7.1]
  def change
    change_column :search_requests, :height, :integer
  end
end
