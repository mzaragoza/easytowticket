class AnsweringServiceCare.Views.Admins.CallControlScriptItemView extends AnsweringServiceCare.Views.Admins.PromptScriptItemView
  initialize: (opts) ->
    super(opts)
    @promptLabel = 'Call Control'
    @scriptType = 'CallControlScriptItem'
