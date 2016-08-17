class CreateUserInterests < ActiveRecord::Migration
  def change
    create_table :user_interests do |t|
      t.integer :user_id, :null => false	
      t.integer :interest_id, :null => false	
      t.boolean :is_deleted, :default => false	

      t.timestamps
    end
  end
end
