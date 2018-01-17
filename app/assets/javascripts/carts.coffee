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
    (($) ->
      $('.spinner .btn:first-of-type').on 'click', ->
        $('.spinner input').val parseInt($('.spinner input').val(), 10) + 1
        return
        $('.spinner .btn:last-of-type').on 'click', ->
          $('.spinner input').val parseInt($('.spinner input').val(), 10) - 1
          return
        return
      ) jQuery



  show: =>
    return


  new: =>
    return


  edit: =>
    return
