class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string "interest", :null => false	
      t.string "description", :null => false
      t.boolean "is_deleted", :default => false
      t.timestamps
    end
  end
end
