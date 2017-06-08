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
    console.log("in new!")
    $(document).on "change",".switch_location",->
      type = $(this).val()
      # $(".location_section[type=#{type}]").
    return


  edit: =>
    return
