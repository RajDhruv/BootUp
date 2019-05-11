class CreateTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :timelines do |t|
      t.string :timeable_type
      t.integer :timeable_id

      t.timestamps
    end
  end
end
