class AddForeheadToSearchRequest < ActiveRecord::Migration[7.1]
  def change
    add_column :search_requests, :forehead, :string
  end
end
