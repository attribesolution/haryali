class AddLocationRefToTimelineEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :timeline_events, :location, foreign_key: true
  end
end
