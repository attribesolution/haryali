class AddLeadsToTimelineEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :timeline_events, :lead_id, :bigint
  end
end
