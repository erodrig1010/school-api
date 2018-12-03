class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
        t.references :school, foreign_key: true
        t.string :name
        t.text :description
        t.string :url
        t.string :course_type
        t.string :commitment
        t.integer :hours_per_week
        t.string :start_date
        t.integer :class_size
        t.integer :duration_in_weeks

        t.timestamps
    end
  end
end
