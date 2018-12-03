class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
        t.references :school, foreign_key: true
        t.string :city
        t.decimal :latitude
        t.decimal :longitude
        t.string :county
        t.string :state
        t.string :postcode
        t.string :country

        t.timestamps
    end
  end
end
