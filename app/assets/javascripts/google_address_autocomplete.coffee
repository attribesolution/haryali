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
    if $('#location_lat').length < 1
      $("#haryali_location_lat").val(location.lat())
      $("#haryali_location_lng").val(location.lng())
      message = "click on the map to change location" 
    else
      $("#location_lat").val(location.lat()).trigger('change')
      $("#location_lng").val(location.lng())
      message = "click on the map to change planting location" 
    if window.marker == undefined
      window.marker = new google.maps.Marker(
        position: location
        icon: 'http://maps.google.com/mapfiles/ms/icons/tree.png'
        map: window.map)
    else
      window.marker.setPosition location
    window.map.panTo location 
    
    if window.message == undefined
      window.message = new google.maps.InfoWindow content: message
    else 
      window.message.setContent message
    window.message.open window.map, window.marker 

  if $("#autocomplete_address").length > 0
    initialize_address("autocomplete_address")
  