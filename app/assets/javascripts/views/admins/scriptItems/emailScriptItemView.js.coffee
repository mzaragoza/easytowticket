class AnsweringServiceCare.Views.Admins.EmailScriptItemView extends AnsweringServiceCare.Views.Admins.PlainScriptItemView
  template: JST['templates/admins/scriptItems/emailScriptItem']

  initialize: (opts) ->
    super(opts)
    @scriptType = 'EmailScriptItem'
    @emailField = new AnsweringServiceCare.Views.Admins.FieldItemView(scriptItemView: @, type: 'email', label: 'Email')
    @fields = [@emailField]

  render: ->
    scriptItemHtml = $(@template(prompt: @prompt))
    scriptItemHtml.filter('.email-field').html(@emailField.render())
    @previewItem()
    @$el.html(scriptItemHtml)
