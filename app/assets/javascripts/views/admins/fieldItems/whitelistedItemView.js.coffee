class AnsweringServiceCare.Views.Admins.WhitelistedItemView extends AnsweringServiceCare.Views.Admins.FieldItemView

  initialize: (opts) ->
    super(opts)
    @label = _(@type).titleize().replace(/_/g, ' ')
