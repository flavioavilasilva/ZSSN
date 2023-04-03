class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.integer :age
      t.string :gender
      t.string :latitude
      t.string :longitude
      t.boolean :infected, default: false

      t.timestamps
    end
  end
end
