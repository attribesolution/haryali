window.App ||= {}
class App.Locations extends App.Base

  beforeAction: (action) =>
    return

  afterAction: (action) =>
    return

  index: =>
    return

  show: =>
    new (google.maps.Map)($('#map'),
      zoom: 17
      center:
        lat: 24
        lng: 61
      mapTypeId: 'terrain'
      draggable: false
      zoomControl: false
      scrollwheel: false
      disableDoubleClickZoom: true
      streetViewControl: false)
    return

  new: =>
    return

  edit: =>
    return
