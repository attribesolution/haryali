window.App ||= {}
class App.Leads extends App.Base

  beforeAction: (action) =>
    return

  afterAction: (action) =>
    return

  index: =>
    return

  show: =>
    return

  new: =>
    @couponVerify = new Utility.VerifyCoupon($("#lead_coupon_code"))

    if $('.active').length > 2
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
            else
              window.alert 'No results found'
          else
            window.alert 'Geocoder failed due to: ' + status
          return
        return

    $(document).on "change",".switch_location",->
      type = $(this).val()
      $(".location_section").hide()
      $(".location_section[type=#{type}]").show()

    $(document).on "change","#lead_quantity", ->
      quantity = parseInt($(this).val())
      price = parseFloat($(this).attr("price"))
      discount = parseFloat($(this).attr("discount"))
      total_price = calculateTotalPrice(quantity,price,discount)
      $(".total_price").text("Rs. #{(total_price).toFixed(2)}")

    calculateTotalPrice = (quantity,price,discount) ->
      return (quantity*price) - discount

    ## ######## Select a tree
    $(".lnk_tree").click ->
      if $(".lnk_tree").hasClass('disabled') 
        return 
      $(".lnk_tree").removeClass("selected_tree")
      $(this).addClass("selected_tree")
      
      id = $(this).attr("tree_id")
      $("#lead_plant_id").val(id)

    $(".haryali_location").click -> 
      $(".haryali_location").removeClass("selected_location")
      $(this).addClass("selected_location")
      id = $(this).attr("location_id")
      $("#lead_location_id").val(id)

    $.validator.addMethod 'pkphone', ((value) ->
      value.match /^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$/
    ), 'Please enter a valid phone number'
    
    $('#new_lead').validate 
      rules: 
        'lead[name]':
          required: true
        'lead[contact]':
          required: true
          pkphone: true
          minlength: 11
          maxlength: 14
        'lead[email]':
          required: true

    return

  edit: =>
    return
