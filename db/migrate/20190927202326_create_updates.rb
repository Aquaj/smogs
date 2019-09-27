class CreateUpdates < ActiveRecord::Migration[6.0]
  def change
    create_table :updates do |t|
      t.datetime :published_at
      t.references :arc, null: false, foreign_key: true

      t.timestamps
    end
  end
end
