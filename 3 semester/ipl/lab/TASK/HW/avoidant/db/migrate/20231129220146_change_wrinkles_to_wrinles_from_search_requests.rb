class ChangeWrinklesToWrinlesFromSearchRequests < ActiveRecord::Migration[7.1]
  change_table :search_requests do |table|
    table.change :wrinkles, :string
  end
end
