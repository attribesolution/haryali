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
    
    readURL = (input) ->
      if input.files and input.files[0]
        reader = new FileReader
        reader.onload = (e) ->
          $('#img_prev').attr 'src', e.target.result
          return
        reader.readAsDataURL input.files[0]

    $('#plant-image').change ->
      $('#img_prev').removeClass 'hidden'
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
      $('#img_prev').removeClass 'hidden'
      readURL this

    return
