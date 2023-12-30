class ChangeFhToFhFromSearchRequests < ActiveRecord::Migration[7.1]
  change_table :search_requests do |table|
    table.change :facial_hair, :string
  end
end
