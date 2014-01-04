class AnsweringServiceCare.Views.Admins.PhoneScriptItemView extends AnsweringServiceCare.Views.Admins.WhitelistedScriptItemView
  template: JST['templates/admins/scriptItems/phoneScriptItem']

  initialize: (opts) ->
    super(opts)
    @scriptType = 'PhoneScriptItem'
