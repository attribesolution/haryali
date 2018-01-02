class App.Visitors extends App.Base

  index: =>
    console.log 'users#show'

  show: =>
    coordinates = 
      lat: parseFloat($('.lat').val()) 
      lng: parseFloat($('.lng').val()) 
    unless isNaN(coordinates['lat'])
      window.map = new google.maps.Map($('.map')[0],
        zoom: 15
        center: coordinates
        mapTypeId: 'terrain'
        streetViewControl: false)
      window.marker = new google.maps.Marker(
        position: coordinates
        icon: 'http://maps.google.com/mapfiles/ms/icons/tree.png'
        map: window.map)

    readURL = (input) ->
      if input.files and input.files[0]
        reader = new FileReader
        reader.onload = (e) ->
          $(input.nextSibling.nextSibling).attr 'src', e.target.result
          return
        reader.readAsDataURL input.files[0]

    window.onload = ->
      if $('#add_event').length > 0
        # link add event button to validate new event fields on create 
        $('#add_event').removeClass 'disabled'
        $('#add_event')[0].onclick = eventHandler

      new (google.maps.places.Autocomplete)(document.getElementById('current_location'), componentRestrictions: {country: "pk"}, types: [ 'establishment','geocode' ])
      window.directionsDisplay = new google.maps.DirectionsRenderer();
      window.directionsService = new google.maps.DirectionsService();
      window.directionsDisplay.setMap(window.map);
      $('#get_directions')[0].disabled = false
      return

    $('#get_directions').click ->
      unless $('#current_location').val() == "" || window.directionsService == undefined
        this.disabled = true
        this.innerHTML = 'Calculating... (Please Wait)'
        calculateRoute() 
      return

    calculateRoute = ->
      request = 
        origin: $('#current_location').val()
        destination: 
          lat: parseFloat($('#location_lat').val()) 
          lng: parseFloat($('#location_lng').val()) 
        travelMode: 'DRIVING'
        region: 'PK'
      directionsService.route request, (result, status) ->
        if status == 'OK'
          directionsDisplay.setDirections result
          window.marker.setMap null
      $('#get_directions')[0].innerHTML = 'Get Directions'
      $('#get_directions')[0].disabled = false
      return