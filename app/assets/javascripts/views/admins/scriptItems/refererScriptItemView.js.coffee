class AnsweringServiceCare.Views.Admins.RefererScriptItemView extends AnsweringServiceCare.Views.Admins.PlainScriptItemView
  initialize: (opts) ->
    super(opts)
    @promptLabel = 'Referer'
    @scriptType = 'RefererScriptItem'


  addExistingFields: (fieldsHash) ->
    if fieldsHash
      super(fieldsHash)
    else
      @refererField = new AnsweringServiceCare.Views.Admins.FieldItemView(scriptItemView: @, type: 'referer', label: @promptLabel)
      @fields = [@refererField]
