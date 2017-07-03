$ ->
  autocomplete = undefined
  window.initialize_address = (address_elem_id) ->
    # Create the autocomplete object, restricting the search
    # to geographical location types.
    autocomplete = new (google.maps.places.Autocomplete)(document.getElementById(address_elem_id), componentRestrictions: {country: "pk"}, types: [ 'establishment','geocode' ])
    # When the user selects an address from the dropdown,
    # populate the address fields in the form.
    google.maps.event.addListener autocomplete, 'place_changed', ->
      fillInAddress()
      return
    return

  fillInAddress = ->
    place = autocomplete.getPlace()
    location = place.geometry.location
    
    # fill lat lng 
    $("#location_lat").val(location.lat())
    $("#location_lng").val(location.lng())
    if window.marker == undefined
      window.marker = new google.maps.Marker(
        position: location
        map: window.map)
    else
      window.marker.setPosition location
    window.map.panTo location 
    
    if window.message == undefined
      window.message = new google.maps.InfoWindow content: "click on the map to change planting location" 
    else 
      window.message.setContent "click on the map to change planting location"
    window.message.open window.map, window.marker 

  if $("#autocomplete_address").length > 0
    initialize_address("autocomplete_address")
  