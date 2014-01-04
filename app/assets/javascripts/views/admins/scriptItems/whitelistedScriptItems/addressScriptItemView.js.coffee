class AnsweringServiceCare.Views.Admins.AddressScriptItemView extends AnsweringServiceCare.Views.Admins.WhitelistedScriptItemView
  template: JST['templates/admins/scriptItems/addressScriptItem']

  initialize: (opts) ->
    super(opts)
    @scriptType = 'AddressScriptItem'
