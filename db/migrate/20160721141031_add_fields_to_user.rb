class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :middle_name, :string
    add_column :users, :zip_code, :integer
    add_column :users, :ethnicity_id, :integer
    add_column :users, :pokemongo_team_id, :integer
    add_column :users, :favorite_pokemon, :string
    add_column :users, :hobbies, :string
  end
end
