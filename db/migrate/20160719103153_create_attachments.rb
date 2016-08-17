class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :attachable_id
      t.string :attachable_type
      t.string :attachment, null: false
	  t.string :original_filename
	  t.string :content_type
      t.timestamps
    end
  end
end
