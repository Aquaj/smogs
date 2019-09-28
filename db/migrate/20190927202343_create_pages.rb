class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.bigint :position
      t.string :title
      t.text :content
      t.references :publication, null: false, foreign_key: true

      t.timestamps
    end
  end
end
