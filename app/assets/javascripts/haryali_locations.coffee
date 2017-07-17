window.App ||= {}
class App.HaryaliLocations extends App.Base

  beforeAction: (action) =>
    return

  afterAction: (action) =>
    return

  index: =>
    return

  show: =>
    return

  new: =>
    return

  edit: =>
    coordinates = 
      lat: parseFloat($('#haryali_location_lat').val()) 
      lng: parseFloat($('#haryali_location_lng').val()) 
    if isNaN(coordinates.lat)
      coordinates.lat = 24.8615
      coordinates.lng = 67.0099
    window.map = new google.maps.Map($('.map')[0],
      zoom: 15
      center: coordinates
      mapTypeId: 'terrain'
      draggable: true
      zoomControl: false
      scrollwheel: true
      disableDoubleClickZoom: false
      streetViewControl: false)
    window.marker = new google.maps.Marker(
        position: coordinates
        map: window.map)
    window.message = new google.maps.InfoWindow content: "click on the map to change location" 
    window.message.open window.map, window.marker 
    window.geocoder = new google.maps.Geocoder 
    
    window.map.addListener 'click', (e) ->
      geocoder.geocode { 'location': e.latLng }, (results, status) ->
        if status == 'OK'
          if results[1]
            # if click within Pakistan 
            if results[1].formatted_address.split(' ').slice(-1)[0] == 'Pakistan'
              $("#haryali_location_lat").val(e.latLng.lat())
              $("#haryali_location_lng").val(e.latLng.lng())
              $("#autocomplete_address").val(results[1].formatted_address)
              window.marker.setPosition e.latLng 
              window.map.panTo e.latLng 
              window.message.setContent "set location here" 
              window.message.open window.map, window.marker 
              $("autocomplete_address").valid()
              $("autocomplete_address").focus()
          else
            window.alert 'No results found'
        else
          window.alert 'Geocoder failed due to: ' + status
    
    $('.simple_form').validate 
      rules: 
        'haryali_location[type]':
          required: true
        'haryali_location[address]':
          required: true
        'haryali_location[lat]':
          required: true
        'haryali_location[lng]':
          required: true
        'haryali_location[current]':
          required: true
        'haryali_location[target]':
          required: true
    return
