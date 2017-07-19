window.App ||= {}
class App.Locations extends App.Base

  beforeAction: (action) =>
    return

  afterAction: (action) =>
    return

  index: =>
    return

  show: =>
    coordinates = 
      lat: parseFloat($('.lat').val()) 
      lng: parseFloat($('.lng').val()) 
    unless isNaN(coordinates['lat'])
      map = new google.maps.Map($('.map')[0],
        zoom: 15
        center: coordinates
        mapTypeId: 'terrain'
        draggable: false
        zoomControl: false
        scrollwheel: false
        disableDoubleClickZoom: true
        streetViewControl: false)
      new google.maps.Marker(
        position: coordinates
        icon: 'http://maps.google.com/mapfiles/ms/icons/tree.png'
        map: map)
    return

  new: =>
    coordinates = 
      lat: parseFloat($('#location_lat').val()) 
      lng: parseFloat($('#location_lng').val()) 
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
    window.geocoder = new google.maps.Geocoder 
    
    window.map.addListener 'click', (e) ->
      geocoder.geocode { 'location': e.latLng }, (results, status) ->
        if status == 'OK'
          if results[1]
            # if click within Pakistan 
            if results[1].formatted_address.split(' ').slice(-1)[0] == 'Pakistan'
              $("#location_lat").val(e.latLng.lat())
              $("#location_lng").val(e.latLng.lng())
              $("#autocomplete_address").val(results[1].formatted_address)
              if window.marker == undefined
                window.marker = new google.maps.Marker(
                  position: e.latLng
                  map: window.map)
              else
                window.marker.setPosition e.latLng 
              window.map.panTo e.latLng 
              if window.message == undefined
                window.message = new google.maps.InfoWindow content: "plant here" 
              else
                window.message.setContent "plant here" 
              window.message.open window.map, window.marker 
              $("autocomplete_address").valid()
              $("autocomplete_address").focus()
          else
            window.alert 'No results found'
        else
          window.alert 'Geocoder failed due to: ' + status
    $('#new_location').validate 
      rules: 
        'location[type]':
          required: true
        'location[address]':
          required: true
        'location[lat]':
          required: true
        'location[lng]':
          required: true
        'location[target]':
          required: true
    
    window.onload = ->
      # link add event button to validate new event fields on create 
      $('#add_event')[0].onclick = validateEvent 
      return

    validateEvent = ->
      temp = @parentNode
      setTimeout (->
        $(temp.previousSibling.firstChild.firstChild.firstChild.nextSibling).rules 'add', required: true
        $(temp.previousSibling.firstChild.firstChild.nextSibling.firstChild.nextSibling).rules 'add', required: true
        return
      ), 100
      return
    return

  edit: =>
    return
