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
    $(document).on "click",".lnk_verify_coupon",->
      $(".preloader").show()
      
      $.get "/coupons/" + $("#lead_coupon_code").val(), (data)->

        $(".preloader").hide()

        if(data.error)
          $(".status").html("Invalid code")
        else
          $("#lead_coupon_id").val(data.coupon.id)
          $(".status").html("Verified")


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
      $(".lnk_tree").removeClass("selected_tree")
      $(this).addClass("selected_tree")
      
      id = $(this).attr("tree_id")
      $("#lead_plant_id").val(id)


    return




  edit: =>
    return
