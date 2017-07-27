window.App ||= {}
class App.Plants extends App.Base

  beforeAction: (action) =>
    return

  afterAction: (action) =>
    return

  index: =>
    return

  show: =>
    return

  new: =>
    $('#new_plant').validate 
      rules: 
        'plant[name]':
          required: true
        'plant[detail]':
          required: true
        'plant[price]':
          required: true
        'plant[image]':
          required: true
      messages:
        'plant[image]':
          required: ""
    
    readURL = (input) ->
      if input.files and input.files[0]
        reader = new FileReader
        reader.onload = (e) ->
          $('#img_prev').attr 'src', e.target.result
          return
        reader.readAsDataURL input.files[0]

    $('#plant-image').change ->
      if this.files and this.files[0].size > 1000000
        window.alert "This file exceeds the maximum allowed file size (5 MB)"
        $(this).val('')
        $('#img_prev').attr 'src', ""
        $('#img_prev')[0].style.visibility = 'hidden'
      else
        $('#img_prev')[0].style.visibility = 'visible'
        readURL this
    return

  edit: =>
    readURL = (input) ->
      if input.files and input.files[0]
        reader = new FileReader
        reader.onload = (e) ->
          $('#img_prev').attr 'src', e.target.result
          return
        reader.readAsDataURL input.files[0]

    $('#plant-image').change ->
      if this.files and this.files[0].size > 1000000
        window.alert "This file exceeds the maximum allowed file size (5 MB)"
        $(this).val('')
        $('#img_prev').attr 'src', ""
        $('#img_prev')[0].style.visibility = 'hidden'
      else
        $('#img_prev')[0].style.visibility = 'visible'
        readURL this

    return
