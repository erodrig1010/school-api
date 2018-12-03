class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
        t.references :school, foreign_key: true
        t.string :name
        t.string :url

        t.timestamps
    end
  end
end
