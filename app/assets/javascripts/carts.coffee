window.App ||= {}
class App.Carts extends App.Base

  beforeAction: (action) =>
    return


  afterAction: (action) =>
    return


  index: =>
    $ ->
      $(document).ready ->
        $('.flexslider').flexslider
          animation: 'fade'
          slideshowSpeed: 4000
          animationSpeed: 600
          controlNav: false
          directionNav: true
          controlsContainer: '.flex-container'
        return
      return


  cart: =>
    $(".subcategory").click ->
      $.ajax
        type: 'get'
        url: '/cart'
        data: 
          id: this.id

  show: =>
    return


  new: =>
    return


  edit: =>
    return
