class AnsweringServiceCare.Views.Admins.WhitelistedScriptItemView extends AnsweringServiceCare.Views.Admins.PlainScriptItemView

  addFieldItem: (e) ->
    e.preventDefault()
    type = $(e.target).val()
    @fields.push(new AnsweringServiceCare.Views.Admins.WhitelistedItemView(scriptItemView: @, type: type, position: @fields.length))
    @render()
