class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :schools do |t|
        t.string :created_by
        t.string :name
        t.string :source_url
        t.string :etag
        t.text :about
        t.string :website
        t.string :email
        t.boolean :job_guarantee
        t.boolean :gi_bill
        t.boolean :job_assistance
        t.boolean :licensing
        t.boolean :housing
        t.boolean :corporate_training
        t.boolean :closed

        t.timestamps
    end
  end
end
