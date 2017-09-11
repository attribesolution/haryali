json.meta do
  json.success true
  json.status 200
  json.message "Fetched all Haryali Locations."
end
json.data do
  json.array! @locations do |location|
    json.id location.id
    json.latitude location.lat
    json.longitude location.lng
    json.optional_address location.optional_address
    json.address location.address
    json.current location.current
    json.target location.target
    json.is_active location.is_active
    
    # if location.timeline_events?
    #   json.timeline_events location.timeline_events.order(created_at: :DESC)
    # end
  end
end
