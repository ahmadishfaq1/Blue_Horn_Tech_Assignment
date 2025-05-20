class CreateVisitLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :visit_logs do |t|
      t.string :event_type
      t.datetime :timestamp
      t.float :latitude
      t.float :longitude
      t.references :shift, null: false, foreign_key: true

      t.timestamps
    end
  end
end
