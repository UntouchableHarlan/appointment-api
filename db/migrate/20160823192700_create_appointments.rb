class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.string :name
      t.string :email
      t.string :start_time
      t.string :end_time
      t.string :date

      t.timestamps
    end
  end
end
