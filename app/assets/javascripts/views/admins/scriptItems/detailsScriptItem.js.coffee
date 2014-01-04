class AnsweringServiceCare.Views.Admins.DetailsScriptItemView extends AnsweringServiceCare.Views.Admins.PlainScriptItemView
  template: JST['templates/admins/scriptItems/detailsScriptItem']

  initialize: (opts) ->
    super(opts)
    @scriptType = 'DetailsScriptItem'
    @detailsField = new AnsweringServiceCare.Views.Admins.FieldItemView(scriptItemView: @, type: 'details', required: true, label: 'Details')
    @fields = [@detailsField]
