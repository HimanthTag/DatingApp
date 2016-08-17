class AddReceiverIdToUserMessages < ActiveRecord::Migration
  def change
  	add_column :user_messages, :receiver_id, :integer, :null=>false
  end
end
