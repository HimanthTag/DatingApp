class CreateEthnicities < ActiveRecord::Migration
  def change
    create_table :ethnicities do |t|
      t.string :name
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
