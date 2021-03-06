class Utility.VerifyCoupon

  constructor: ($element) ->
    @verify($element)
    return this

  verify: ($element) =>
    counter = -1
    code = ""
    coupon = ""

    $element.bind 'input', ->
      if ($(this).val().length > 1)
        if ($(this).val() != code)
          #$(".status").hide()
          $('.verified').hide()
          $('.invalid').hide()
          code = $(this).val()
          counter++ 
          setTimeout ( ->
            counter-- 
            if (counter < 0)
              $.get "/coupons/" + code, (data)->
                if(data.error)
                  $(".status").html("Invalid")
                  $('.invalid').show()
                  $("#lead_coupon_id").val("")
                  $($(".lnk_tree")[1]).removeClass('disabled')
                  $($(".lnk_tree")[2]).removeClass('disabled')
                else
                  coupon = data.coupon.id
                  $(".status").html("Verified")
                  $('.verified').show()
                  $("#lead_coupon_id").val(coupon)

                  $(".lnk_tree").removeClass('selected_tree')
                  $($(".lnk_tree")[0]).addClass('selected_tree')
                  id = $($(".lnk_tree")[0]).attr("tree_id")
                  $("#lead_plant_id").val(id)
                  $($(".lnk_tree")[1]).addClass('disabled')
                  $($(".lnk_tree")[2]).addClass('disabled')
                #$(".status").show()
          ), 1000
        else
          #$(".status").show()
          #console.log $(".status").html()
          if $(".status").html() == "Verified"
            $(".lnk_tree").removeClass('selected_tree')
            $($(".lnk_tree")[0]).addClass('selected_tree')
            id = $($(".lnk_tree")[0]).attr("tree_id")
            $("#lead_plant_id").val(id)
            $($(".lnk_tree")[1]).addClass('disabled')
            $($(".lnk_tree")[2]).addClass('disabled')
            $("#lead_coupon_id").val(coupon)
            $('.verified').show()
          else 
            $('.invalid').show()
      else
        #$(".status").hide()
        $('.verified').hide()
        $('.invalid').hide()
        $($(".lnk_tree")[1]).removeClass('disabled')
        $($(".lnk_tree")[2]).removeClass('disabled')
        $("#lead_coupon_id").val("")
      return
