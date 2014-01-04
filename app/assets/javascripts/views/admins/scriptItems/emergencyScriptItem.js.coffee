class AnsweringServiceCare.Views.Admins.EmergencyScriptItemView extends AnsweringServiceCare.Views.Admins.PlainScriptItemView
  initialize: (opts) ->
    super(opts)
    @promptLabel = 'Emergency Script Prompt'
    @scriptType = 'EmergencyScriptItem'

  addExistingFields: (fieldsHash) ->
    if fieldsHash
      super(fieldsHash)
    else
      @emergencyField = new AnsweringServiceCare.Views.Admins.FieldItemView(scriptItemView: @, type: 'emergency', label: 'Is this an emergency?')
      @fields = [@emergencyField]
