class CreateUserImages < ActiveRecord::Migration[6.1]
  def change
    create_table :user_images do |t|
      t.references :user
      t.string :alt_text, null: false, default:''
      t.integer :position
      t.timestamps
    end
  end
end
