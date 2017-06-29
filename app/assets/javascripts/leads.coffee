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
