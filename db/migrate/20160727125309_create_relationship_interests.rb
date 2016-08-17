class CreateRelationshipInterests < ActiveRecord::Migration
  def change
    create_table :relationship_interests do |t|
      t.string :name
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
