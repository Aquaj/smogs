class CreateArcs < ActiveRecord::Migration[6.0]
  def change
    create_table :arcs do |t|
      t.string :name
      t.bigint :position
      t.references :story, null: false, foreign_key: true

      t.timestamps
    end
  end
end
