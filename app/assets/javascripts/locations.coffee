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
        map: map)
    return

  new: =>
    return

  edit: =>
    return
