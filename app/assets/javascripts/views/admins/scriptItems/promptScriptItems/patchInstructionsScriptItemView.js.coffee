class AnsweringServiceCare.Views.Admins.PatchInstructionsScriptItemView extends AnsweringServiceCare.Views.Admins.PromptScriptItemView
  initialize: (opts) ->
    super(opts)
    @promptLabel = 'Patch Instructions'
    @scriptType = 'PatchInstructionsScriptItem'
