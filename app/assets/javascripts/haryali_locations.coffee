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
        icon: 'http://maps.google.com/mapfiles/ms/icons/tree.png'
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

    readURL = (input) ->
      if input.files and input.files[0]
        reader = new FileReader
        reader.onload = (e) ->
          $(input.nextSibling.nextSibling).attr 'src', e.target.result
          return
        reader.readAsDataURL input.files[0]

    count = 0
    window.onload = ->
      # validate all existing event fields 
      events = document.getElementsByClassName "nested-fields"
      i = 0
      while i < events.length
        $(events[i].firstChild.firstChild.firstChild.nextSibling).rules 'add', required: true
        $(events[i].firstChild.firstChild.nextSibling.firstChild.nextSibling).rules 'add', required: true
        i++
        $('#event-image')[0].id = "event-image" + count
        $('#img_prev')[0].id = "img_prev" + count
        $('#event-image' + count).change ->
          this.nextSibling.nextSibling.style.visibility = 'visible'
          readURL this
        count++
      # link add event button to validate new event fields on create 
      $('#add_event').removeClass 'disabled'
      $('#add_event')[0].onclick = validateEvent 
      return

    validateEvent = ->
      temp = @parentNode
      setTimeout (->
        $(temp.previousSibling.firstChild.firstChild.firstChild.nextSibling).rules 'add', required: true
        $(temp.previousSibling.firstChild.firstChild.nextSibling.firstChild.nextSibling).rules 'add', required: true
        
        $('#event-image')[0].id = "event-image" + count
        $('#img_prev')[0].id = "img_prev" + count
        $('#event-image' + count).change ->
          if this.files and this.files[0].size > 5000000
            window.alert "This file exceeds the maximum allowed file size (5 MB)"
            $(this).val('')
            $(this.nextSibling.nextSibling).attr 'src', ""
            this.nextSibling.nextSibling.style.visibility = 'hidden'
          else
            this.nextSibling.nextSibling.style.visibility = 'visible'
            readURL this
        count++
        return
      ), 100
      return
    return
