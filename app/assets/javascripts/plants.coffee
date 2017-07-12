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
    return

  edit: =>
    return
