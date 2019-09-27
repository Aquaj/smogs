class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.bigint :position
      t.string :title
      t.text :content
      t.string :url_slug
      t.references :update, null: false, foreign_key: true

      t.timestamps
    end
  end
end
