class AddSearcherEmailAndSearcherNameToFinds < ActiveRecord::Migration[7.1]
  def change
    add_column :finds, :searcher_email, :string
    add_column :finds, :searcher_name, :string
  end
end
