class AddNewFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :height_feet, :integer
    add_column :users, :height_inch, :integer
    add_column :users, :relationship_interest_id, :integer
  end
end
