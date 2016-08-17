class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.string :status
      t.string :description
      t.boolean :is_deleted, :default => false

      t.timestamps
    end
  end
end
