class CreateInfectedAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :infected_alerts do |t|
      t.references :user, null: false, foreign_key: true
      t.bigint :warned_by_id, null: false

      t.timestamps
    end

    add_foreign_key "infected_alerts", "users", column: "warned_by_id"
  end
end
