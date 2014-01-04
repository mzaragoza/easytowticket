class AnsweringServiceCare.Views.Admins.ClosingMessageScriptItemView extends AnsweringServiceCare.Views.Admins.PromptScriptItemView
  initialize: (opts) ->
    super(opts)
    @promptLabel = 'Closing Message'
    @scriptType = 'ClosingMessageScriptItem'
