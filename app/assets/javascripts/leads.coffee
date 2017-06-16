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
    counter = -1
    code = ""

    $("#lead_coupon_code").bind 'input', ->
      if ($(this).val().length > 1)
        if ($(this).val() != code)
          $(".status").hide()
          code = $(this).val()
          counter++ 
          setTimeout ( ->
            counter-- 
            if (counter < 0)
              $.get "/coupons/" + code, (data)->
                if(data.error)
                  $(".status").html("Invalid code")
                else
                  $(".status").html("Verified")
                $(".status").show()
          ), 1000
        else
          $(".status").show()
      else
        $(".status").hide()
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

    $.validator.addMethod 'intlphone', ((value) ->
      value.match /^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$/
    ), 'Please enter a valid phone number'
    
    $('#new_lead').validate 
      rules: 
        'lead[name]':
          required: true
        'lead[contact]':
          required: true
          intlphone: true
          minlength: 11
          maxlength: 14
        'lead[email]':
          required: true
 
    return

  edit: =>
    return
