window.App ||= {}
class App.Products extends App.Base

  beforeAction: (action) =>
    return


  afterAction: (action) =>
    return


  index: =>
    return


  show: =>
    return


  new: =>
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
    

    $('#product_category_id').change ->
      value = $(this).val()
      $.ajax
        type: 'get'
        url: '/products/option'
        data: 
          id: value

    $('.product_sub_category select').empty();
    return


  edit: =>
    return
