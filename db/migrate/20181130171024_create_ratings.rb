class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
        t.references :school, foreign_key: true
        t.decimal :aggregate_rating
        t.integer :review_count

        t.timestamps
    end
  end
end
