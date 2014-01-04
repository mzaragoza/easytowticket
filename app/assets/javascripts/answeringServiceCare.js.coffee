window.AnsweringServiceCare =
  Views: {}
  makeTooltip: (message, type="notice") ->
    $.pnotify(
      text: message
      hide: false
      closer: false
      sticker: false
      history: false
      type: type
      animate_speed: 100
      opacity: .9
      icon: 'ui-icon ui-icon-comment'

      # Setting stack to false causes Pines Notify to ignore this notice when positioning.
      stack: false
      after_init: (pnotify) ->

        # Remove the notice if the user mouses over it.
        pnotify.mouseout ->
          pnotify.pnotify_remove()

      before_open: (pnotify) ->

        # This prevents the notice from displaying when it's created.
        pnotify.pnotify before_open: null
        false
    )
  init: ->
    console.log 'ASC loaded'

    # importing string manipulation functions from underscore string
    _.mixin _.string.exports()

$(document).ready ->
  AnsweringServiceCare.init()
