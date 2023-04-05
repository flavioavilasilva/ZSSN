class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.integer :points

      t.timestamps
    end
    
    add_index :items, :name
  end
end
