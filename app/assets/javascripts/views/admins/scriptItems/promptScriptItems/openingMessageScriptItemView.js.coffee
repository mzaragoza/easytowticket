class AnsweringServiceCare.Views.Admins.OpeningMessageScriptItemView extends AnsweringServiceCare.Views.Admins.PromptScriptItemView
  initialize: (opts) ->
    super(opts)
    @promptLabel = 'Opening Message'
    @scriptType = 'OpeningMessageScriptItem'
