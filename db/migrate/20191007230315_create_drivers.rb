class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :vin
      t.string :string

      t.timestamps
    end
  end
end
