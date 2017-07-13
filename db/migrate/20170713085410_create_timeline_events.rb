class CreateTimelineEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :timeline_events do |t|
      t.string :title
      t.string :caption
      t.string :image

      t.timestamps
    end
  end
end
