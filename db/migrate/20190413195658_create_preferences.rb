class CreatePreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :preferences do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :panel_color

      t.timestamps
    end
  end
end
