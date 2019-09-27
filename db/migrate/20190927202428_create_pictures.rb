class CreatePictures < ActiveRecord::Migration[6.0]
  def change
    create_table :pictures do |t|
      t.text :alt_text
      t.references :page, null: false, foreign_key: true

      t.timestamps
    end
  end
end
