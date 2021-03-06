window.App ||= {}
class App.HaryaliYaads extends App.Base

  beforeAction: (action) =>
    return

  afterAction: (action) =>
    return

  index: =>
    $(document).ready ->
      # text_max = 14
      text_min = 0
      $('#lead_dedicate_name').focus ->
        $(this).keyup ->
        $('#textarea_feedback').html '(' + text_min + ' /' +' 30)'
        $('#lead_dedicate_name').keyup ->
          text_length = $('#lead_dedicate_name').val().length
          text_remaining = text_min + text_length

          if text_remaining <= 30
            $('#textarea_feedback').html  '(' + text_remaining + ' /' +' 30)'
          return
 
        $('#lead_dedicate_name').blur ->
          $('#textarea_feedback').hide()
          return
        
        $('#lead_dedicate_name').keyup ->
          $('#name_plaque').css 'color', '#D4AF37'
          return
        $('#lead_dedicate_name').focusout ->
          $('.name-text').css 'color', '#2f1902'
          return
        return

      $('#lead_dedicate_name').keyup ->
        textLength = this.value.length
        if (textLength > 15 && textLength < 20)
          console.log('less than 15');
          $('.name-text').css 'font-size', '100%'
        else if (textLength > 20 && textLength < 23)
          console.log('greater than 20');
          $('.name-text').css 'font-size', '90%'
        else if (textLength > 23 && textLength < 27)
          console.log('greater than 20');
          $('.name-text').css 'font-size', '77%'
        return

      
      $('.change-image').click ->
        $('#myImg').hide()
        $('#myImg1').prop('hidden', false)
        return

       
    
      $(document).ready ->
        # Handler for .ready() called.
        $('html, body').animate { scrollTop: $('.yaad-form').offset().top }, 'slow'
        return
            
      tl = new TimelineLite
      form = $('.sub-form')
      sub = $('.submit-under')
      allsub = $('.allsub')
      loader = $('.loader circle')
      loader2 = $('.loader2 circle')
      loaders = [
        loader
        loader2
      ]
      circP = $('.circle-paper')
      TweenMax.set sub,
        opacity: 0.7
        rotationY: 90
      TweenMax.set $('.submit-under, .loader, .loader2, .circle-paper, p.success-dialog, h2.success'), visibility: 'visible'
      TweenMax.set loader,
        drawSVG: '100% 100%'
        rotation: -90
      TweenMax.set circP,
        scaleY: 0
        transformOrigin: '50% 50%'
      TweenMax.set [
        loader2
        circP
      ], opacity: 0
      TweenMax.set $('.success, .success-dialog'), opacity: 0
      if $('#lead_dedicate_name').val().length != 0
        $('#name_plaque')[0].innerText = '"'+$('#lead_dedicate_name').val()+'"'
        $('#textarea_feedback')[0].style.display = "block"
      $('#lead_dedicate_name').bind 'input', ->
        if ($(this).val().length > 0)
          $('#name_plaque')[0].innerText = '"'+$('#lead_dedicate_name').val()+'"'
          $('#textarea_feedback')[0].style.display = "block"
        else
          $('#name_plaque')[0].innerText = ''
          $('#textarea_feedback')[0].style.display = "none"
        return

      $('.submit').on 'click', (e) ->
        e.preventDefault
        # Run Validation 
        if $('#new_lead').valid()
          # Trigger Animations
          tl.to sub, 1,
            opacity: 1
            rotationY: 0
            ease: Expo.easeOut
          tl.add 'flip'
          tl.to $('.submit'), 0.5, {
            rotationX: 90
            ease: Circ.easeOut
          }, 'flip-=1.5'
          tl.to $('.submit'), 0.5, { opacity: 0 }, 'flip-=0.5'
          tl.to sub, 0.25, {
            css:
              borderRadius: '50%'
              backgroundColor: '#d6c7ca'
            ease: Circ.easeOut
          }, 'flip-=0.5'
          tl.to sub, 1.2, {
            scaleX: 0.16
            transformOrigin: '50% 50%'
            ease: Expo.easeOut
          }, 'flip-=0.5'
          tl.fromTo loader, 1, {
            transformOrigin: '50% 50%'
            drawSVG: '50% 50%'
          }, {
            transformOrigin: '50% 50%'
            drawSVG: '100%'
          }, 'flip+=1'
          tl.to sub, 0.8, {
            rotationX: 90
            scaleY: 0
          }, 'flip+=1.2'
          tl.to loader2, 0.1, { opacity: 1 }, 'flip+=1.8'
          tl.to loader2, 0.5, {
            opacity: 1
            transformOrigin: '50% 50%'
            scaleX: 0
            rotation: 180
          }, 'flip+=2'
          tl.to loader2, 0.5, {
            opacity: 1
            transformOrigin: '50% 50%'
            scaleX: 1
            rotation: 180
          }, 'flip+=2.5'
          icon_loading = setInterval(SpinLoader, 1000)
          loader[0].style.visibility = 'hidden'
          $.ajax
            url: '/haryali_yaads/submit_form'
            type: 'put'
            data: 
              'name': $('#lead_name').val()
              'email': $('#lead_email').val()
              'phone': $('#lead_contact').val()
              'memory': $('#lead_dedicate_name').val()
            success: (data) ->
              clearInterval(icon_loading)
              TriggerAnimations()
              return
            error: (err) ->
              #clearInterval(icon_loading)
              # Unhide 'Donate' Button 

        document.getElementById('#hide-image').onclick = ->
          document.getElementById('#loadingImage ').hide()
          return  


      count = 1.8
      SpinLoader = ->
        value = 'flip+='+count
        tl.to loader2, 0.5, {
          opacity: 1
          transformOrigin: '50% 50%'
          scaleX: 0
          rotation: 180
        }, value
        count = count + 0.5
        value = 'flip+='+count
        tl.to loader2, 0.5, {
          opacity: 1
          transformOrigin: '50% 50%'
          scaleX: 1
          rotation: 180
        }, value
        count = count + 0.5

      TriggerAnimations = ->
        tl.add 'success'
        tl.to $('.circle-quill'), 0.5, {
          scaleY: 0
          transformOrigin: '50% 50%'
          ease: Circ.easeOut
        }, 'success'
        tl.to circP, 0.5, {
          scaleY: 1
          opacity: 1
          transformOrigin: '50% 50%'
          ease: Circ.easeIn
        }, 'success'
        tl.to $('.circle-quill'), 0.5, {
          scaleY: 0
          transformOrigin: '50% 50%'
          ease: Circ.easeOut
        }, 'success'
        tl.to $('input'), 0.5, { scaleY: 0 }, 'success'
        tl.to $('.info'), 0.5, { scaleY: 0 }, 'success'
        tl.to $('.success'), 0.5, {
          scaleY: 1
          opacity: 1
        }, 'success+=1'
        tl.to $('.success-dialog'), 1, { opacity: 1 }, 'success+=1'
        tl.to loaders, 0.5, {
          scaleY: 0
          stroke: '#b1dbd3'
          transformOrigin: '50% 50%'
        }, 'success'
        tl.to form, 0.5, { css: backgroundColor: '#7aada5' }, 'success'
        loader2[0].style.visibility = 'hidden'
        return
      return

    $.validator.addMethod 'pkphone', ((value) ->
      value.match /^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$/
    ), 'Please enter a valid phone number'

    $('#new_lead').validate 
      rules: 
        'lead[name]':
          required: true
          maxlength: 20
        'lead[dedicate_name]':
          required: true
          maxlength: 30
        'lead[contact]':
          required: true
          pkphone: true
          minlength: 11
          maxlength: 14
        'lead[email]':
          required: true
          maxlength: 50
    return

  show: =>
    return

  new: =>
    return

  edit: =>
    return


  