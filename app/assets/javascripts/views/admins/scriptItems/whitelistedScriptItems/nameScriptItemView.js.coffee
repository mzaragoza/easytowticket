class AnsweringServiceCare.Views.Admins.NameScriptItemView extends AnsweringServiceCare.Views.Admins.WhitelistedScriptItemView
  template: JST['templates/admins/scriptItems/nameScriptItem']

  initialize: (opts) ->
    super(opts)
    @scriptType = 'NameScriptItem'
