class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string      :title
      t.text        :text
      t.timestamps null: true
    end
  end
end
