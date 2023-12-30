class RenameSearchRequest < ActiveRecord::Migration[7.1]
  def change
    rename_table :search_requests, :finds
  end
end
