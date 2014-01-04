class AnsweringServiceCare.Views.Admins.FormRendererView extends Backbone.View
  events: ->
    'change #message_first_name' : 'replaceCallerName'

  initialize: (opts) ->
    @$el = $('.form-pane')

    @sections = opts.sections || []

    if !$.isEmptyObject(opts.form)
      @addPreviousSections(opts)

    $.validator.addMethod 'lettersOnly', ((value, element) ->
      /^[a-zA-Z\s]+$/.test(value)
      ), 'Please use letters only'

    $('form').validate(
      rules:
        'message[first_name]':
          lettersOnly: true
        'message[last_name]':
          lettersOnly: true
        'message[phone_number]':
          phoneUS: true
    )

  render: ->
    previewHtml = ''
    $.each(@sections, (index, section) ->
      previewHtml += section.renderPreview()
      section.bindTriggers()
    )

    @$el.html(previewHtml)
    @$el.prepend('<h3>Preview</h3>')

  renderPreview: ->
    firstSection = @sections[0]
    @$el.html(firstSection.renderPreview())
    firstSection.bindTriggers()
    @loadIntlTelInput()

  loadIntlTelInput: ->
    $('.intl-phone').intlTelInput
      onlyCountries: ['US', 'CA', 'PH']

  addPreviousSections: (formHash) ->
    $.each(formHash.form, (index, sectionHash) =>
      sectionHash = _.extend(sectionHash, {formRenderer: @})
      @sections.push new AnsweringServiceCare.Views.Admins.SectionView(sectionHash)
    )

  showSections: (triggeredFieldName, sectionNames) ->
    triggeredFieldName = _.trim(triggeredFieldName, '?!')
    previewHtml = if $(".#{triggeredFieldName}").length
      $(".#{triggeredFieldName}").html('')
    else
      $("<div class='#{triggeredFieldName} triggered-section'></div>")

    $.each(sectionNames, (index, sectionName) =>
      chosenSection = _.find(@sections, (section) =>
        sectionName == section.name
      )

      unless $("##{_(sectionName).dasherize()}").length
        previewHtml.append chosenSection.renderPreview()
        chosenSection.bindTriggers()
    )

    @$el.append previewHtml
    @loadIntlTelInput()

  # REFACTOR, DUPLICATE WITH FORMBUILDERVIEW
  buildScriptItem: (type, params) ->
    viewPrefix = "AnsweringServiceCare.Views.Admins"
    eval("new #{viewPrefix}.#{type}View(params)")

  replaceCallerName: (e) ->
    prompts = $('.custom-content')
    callerName = $(e.target).val()
    $.each(prompts, (index, prompt) =>
      $(prompt).html($(prompt).attr('data-prompt').replace('{CALLER_NAME}', callerName))
    )
