window.App ||= {}
class App.Coupons extends App.Base

  beforeAction: (action) =>
    return


  afterAction: (action) =>
    return


  index: =>
    $('#generate_coupons').click ->
      unless isNaN(parseInt($('#quantity').val()))
        this.disabled = true
        this.innerHTML = 'Generating... (Please Wait)'
        $.ajax
          url: '/coupons/generate_coupons'
          type: 'put'
          async: false
          data: 
            'quantity': $('#quantity').val()
        location.reload()
      return
    return


  show: =>
    return


  new: =>
    return


  edit: =>
    return
