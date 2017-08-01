window.App ||= {}
class App.Updates extends App.Base

  beforeAction: (action) =>
    return

  afterAction: (action) =>
    return

  index: =>
    return

  show: =>
    return

  new: =>
    $('#new_update').validate 
      rules: 
        'update[title]':
          required: true
        'update[description]':
          required: true
        'update[image]':
          required: true
      messages:
        'update[image]':
          required: ""
    
    readURL = (input) ->
      if input.files and input.files[0]
        reader = new FileReader
        reader.onload = (e) ->
          $('#img_prev').attr 'src', e.target.result
          return
        reader.readAsDataURL input.files[0]

    $('#update-image').change ->
      if this.files and this.files[0].size > 5000000
        window.alert "This file exceeds the maximum allowed file size (5 MB)"
        $(this).val('')
        $('#img_prev').attr 'src', ""
        $('#img_prev')[0].style.visibility = 'hidden'
      else
        $('#img_prev')[0].style.visibility = 'visible'
        readURL this
    return

  edit: =>
    return
