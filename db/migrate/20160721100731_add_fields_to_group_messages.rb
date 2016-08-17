class AddFieldsToGroupMessages < ActiveRecord::Migration
  def change
  	add_column :group_messages, :group_id, :integer  	
  end
end
