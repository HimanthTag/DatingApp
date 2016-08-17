class AddBodyTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :body_type, :string
    add_column :users, :am_over_18, :boolean
  end
end
