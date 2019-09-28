class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.bigint :publication_order
      t.string :title
      t.text :content
      t.references :publication, null: true, foreign_key: true

      t.timestamps
    end
  end
end
