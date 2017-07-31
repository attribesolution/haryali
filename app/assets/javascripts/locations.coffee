window.App ||= {}
class App.Locations extends App.Base

  beforeAction: (action) =>
    return

  afterAction: (action) =>
    return

  index: =>
    return

  show: =>
    jQuery(document).ready ($) ->
      timelineBlocks = $('.cd-timeline-block')
      offset = 0.8
      #hide timeline blocks which are outside the viewport

      hideBlocks = (blocks, offset) ->
        blocks.each ->
          $(this).offset().top > $(window).scrollTop() + $(window).height() * offset and $(this).find('.cd-timeline-img, .cd-timeline-content').addClass('is-hidden')
          return
        return

      showBlocks = (blocks, offset) ->
        blocks.each ->
          $(this).offset().top <= $(window).scrollTop() + $(window).height() * offset and $(this).find('.cd-timeline-img').hasClass('is-hidden') and $(this).find('.cd-timeline-img, .cd-timeline-content').removeClass('is-hidden').addClass('bounce-in')
          return
        return

      hideBlocks timelineBlocks, offset
      #on scolling, show/animate timeline blocks when enter the viewport
      $(window).on 'scroll', ->
        if !window.requestAnimationFrame then setTimeout((->
          showBlocks timelineBlocks, offset
          return
        ), 100) else window.requestAnimationFrame((->
          showBlocks timelineBlocks, offset
          return
        ))
        return
      return

      
    modal = document.getElementById('myModal')
    modalImg = document.getElementById('img01')

    $('.img1_image').click ->
      modal.style.display = 'block'
      modalImg.src = @src
      return

    span = document.getElementsByClassName('close')[0]

    if span
      span.onclick = ->
        modal.style.display = 'none'
        return

# ---
# generated by js2coffee 2.2.0
    coordinates = 
      lat: parseFloat($('.lat').val()) 
      lng: parseFloat($('.lng').val()) 
    unless isNaN(coordinates['lat'])
      map = new google.maps.Map($('.map')[0],
        zoom: 17
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

    readURL = (input) ->
      if input.files and input.files[0]
        reader = new FileReader
        reader.onload = (e) ->
          $(input.nextSibling.nextSibling).attr 'src', e.target.result
          return
        reader.readAsDataURL input.files[0]

    window.onload = ->
      # link add event button to validate new event fields on create 
      $('#add_event').removeClass 'disabled'
      $('#add_event')[0].onclick = eventHandler
      return
    
    eventHandler = ->
      validateEvent()
      #enableSave()
      return

    count = 0
    validateEvent = ->
      setTimeout (->
        events = document.getElementsByClassName "remove_event"
        temp = events[0].previousSibling.previousSibling.firstChild
        #$(temp.firstChild.nextSibling).rules 'add', required: true
        #$(temp.nextSibling.firstChild.nextSibling).rules 'add', required: true
        
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

    enableSave = ->
      $("#save").removeAttr "disabled"
      setTimeout (->
        events = document.getElementsByClassName "remove_event"
        events[0].onclick = tryDisableSave 
        $(events[0]).removeClass "remove_event"
      ), 100
      return

    tryDisableSave = ->
      events = document.getElementsByClassName "remove_fields"
      setTimeout (->
        if events.length == 0 
          $("#save").attr "disabled", "disabled"
      ), 100
      return
    return

  new: =>
    readURL = (input) ->
      if input.files and input.files[0]
        reader = new FileReader
        reader.onload = (e) ->
          $(input.nextSibling.nextSibling).attr 'src', e.target.result
          return
        reader.readAsDataURL input.files[0]

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
                  icon: 'http://maps.google.com/mapfiles/ms/icons/tree.png'
                  map: window.map)
              else
                window.marker.setPosition e.latLng 
              window.map.panTo e.latLng 
              if window.message == undefined
                window.message = new google.maps.InfoWindow content: "plant here" 
              else
                window.message.setContent "plant here" 
              window.message.open window.map, window.marker 
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
      $('#add_event').removeClass 'disabled'
      $('#add_event')[0].onclick = validateEvent 
      return

    count = 0
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

  edit: =>
    return
