class CreatePagePositions < ActiveRecord::Migration[6.0]
  def change
    create_view :page_positions
  end
end
