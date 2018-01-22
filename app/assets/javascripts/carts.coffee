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
    jQuery(document).ready ->
      jQuery('.carousel[data-type="multi"] .item').each ->
        next = jQuery(this).next()
        if !next.length
          next = jQuery(this).siblings(':first')
        next.children(':first-child').clone().appendTo jQuery(this)
        i = 0
        while i < 2
          next = next.next()
          if !next.length
            next = jQuery(this).siblings(':first')
          next.children(':first-child').clone().appendTo $(this)
          i++
        return
      return

  cart: =>
    $(".subcategory").click ->
      $('li').removeClass('active');
      $(this).addClass('active');
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
