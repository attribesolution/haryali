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
                  $($(".lnk_tree")[1]).removeClass('disabled')
                  $($(".lnk_tree")[2]).removeClass('disabled')
                else
                  $(".status").html("Verified")
                  $("#lead_coupon_id").val(data.coupon.id)

                  $(".lnk_tree").removeClass('selected_tree')
                  $($(".lnk_tree")[0]).addClass('selected_tree')
                  id = $($(".lnk_tree")[0]).attr("tree_id")
                  $("#lead_plant_id").val(id)
                  $($(".lnk_tree")[1]).addClass('disabled')
                  $($(".lnk_tree")[2]).addClass('disabled')
                $(".status").show()
          ), 1000
        else
          $(".status").show()
          console.log $(".status").html()
          if $(".status").html() == "Verified"
            $(".lnk_tree").removeClass('selected_tree')
            $($(".lnk_tree")[0]).addClass('selected_tree')
            id = $($(".lnk_tree")[0]).attr("tree_id")
            $("#lead_plant_id").val(id)
            $($(".lnk_tree")[1]).addClass('disabled')
            $($(".lnk_tree")[2]).addClass('disabled')
      else
        $(".status").hide()
        $($(".lnk_tree")[1]).removeClass('disabled')
        $($(".lnk_tree")[2]).removeClass('disabled')
      return
