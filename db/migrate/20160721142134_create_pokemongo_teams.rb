class CreatePokemongoTeams < ActiveRecord::Migration
  def change
    create_table :pokemongo_teams do |t|
      t.string :name
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
