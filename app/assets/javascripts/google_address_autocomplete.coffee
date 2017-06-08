$ ->
  autocomplete = undefined
  window.initialize_address = (address_elem_id) ->
    # Create the autocomplete object, restricting the search
    # to geographical location types.
    autocomplete = new (google.maps.places.Autocomplete)(document.getElementById(address_elem_id), types: [ 'establishment','geocode' ])
    # When the user selects an address from the dropdown,
    # populate the address fields in the form.
    google.maps.event.addListener autocomplete, 'place_changed', ->
      fillInAddress()
      return
    return

  fillInAddress = ->
    place = autocomplete.getPlace()
    geometry = autocomplete.getPlace().geometry.location

    # fill lat
    $("#location_lat").val(geometry.lat())
    $("#location_lng").val(geometry.lng())

  if $("#autocomplete_address").length > 0
    initialize_address("autocomplete_address")
  