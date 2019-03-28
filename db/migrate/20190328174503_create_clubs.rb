class CreateClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :clubs do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.boolean :active
      t.integer :template_type
      t.integer :membership_type

      t.timestamps
    end
  end
end
