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
        debugger

        $(".preloader").hide()

        if(data.error)
          $(".status").html("Invalid code")
        else
          $(".status").html("Verified")



    $(document).on "change",".switch_location",->
      type = $(this).val()
      # $(".location_section[type=#{type}]").
    return




  edit: =>
    return
