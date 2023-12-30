class RenameFindNameToPeopleFind < ActiveRecord::Migration[7.1]
  def change
    rename_table :finds, :people_finds

    # Обновление внешних ключей
    remove_column :people_finds, :users_id, :integer
    add_reference :people_finds, :users, index: true, foreign_key: true
  end
end
