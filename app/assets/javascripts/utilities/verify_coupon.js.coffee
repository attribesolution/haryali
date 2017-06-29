class Utility.VerifyCoupon

  constructor: ($element) ->
    @verify($element)
    return this

  verify: ($element) =>
    counter = -1
    code = ""

    $element.bind 'input', ->
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
                  $("#lead_coupon_id").val("")
                else
                  $(".status").html("Verified")
                  $("#lead_coupon_id").val(data.coupon.id)
                $(".status").show()
          ), 1000
        else
          $(".status").show()
      else
        $(".status").hide()
      return
