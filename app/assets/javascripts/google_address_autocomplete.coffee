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
    #fillLocality(place);

  if $("#autocomplete_address").length > 0
    initialize_address("autocomplete_address")
  fillLocality = (place) ->
    $("#business_city").val('')
    $("#business_postcode").val('')
    $(".postcode_section").hide()
    i = 0
    while i < place.address_components.length
      addressType = place.address_components[i].types[0]
      if addressType == 'locality' or addressType == 'postal_town'
        $("#business_city").val(place.address_components[i]['long_name'])
      if addressType == 'postal_code'
        post_code = place.address_components[i]['short_name']
        if post_code != ""
          $(".postcode_section").show()
          $("#business_postcode").val(post_code)
      if addressType == 'country'
        country = place.address_components[i]['long_name']
        window.country_code = place.address_components[i]['short_name']
        $("#business_country").val(country)

      i++