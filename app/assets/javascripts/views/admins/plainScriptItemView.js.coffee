class AnsweringServiceCare.Views.Admins.PlainScriptItemView extends Backbone.View
  template: JST['templates/admins/plainScriptItem']
  tagName: 'div'
  className: 'plain-script-item'

  plainScriptEvents:
    'change .field-type-select' : 'addFieldItem'
    'change .prompt-area' : 'updatePrompt'
    'hover .close-script' : 'toggleBackground'
    'click .close-script' : 'destroy'
    'change .variable-select' : 'addVariable'
    'blur .prompt-area' : 'updateCaretPosition'

  extraEvents: {}

  events: ->
    _.extend({}, @plainScriptEvents, @extraEvents)

  initialize: (opts) ->
    @formBuilder = opts.formBuilder
    @section = opts.section
    @position = opts.position
    @prompt = opts.prompt || ''
    @promptLabel = 'Prompt'
    @fields = []
    @scriptType = opts.scriptType || 'PlainScriptItem'
    @formRenderer = opts.formRenderer
    @promptCaretPosition = 0

    @addExistingFields(opts.fields)

  addExistingFields: (fieldsHash) ->
    if fieldsHash
      $.each(fieldsHash, (index, scriptField) =>

        dataSource = if $.isEmptyObject(scriptField.dataSource)
          @dataSource
        else
          scriptField.dataSource

        additionalParams = {scriptItemView: @, dataSource: dataSource, position: @fields.length}
        params = _.extend(scriptField, additionalParams)

        fieldItem = if _.contains(['select', 'radio', 'checkbox'], scriptField.type)
          new AnsweringServiceCare.Views.Admins.SelectItemView(params)
        else
          new AnsweringServiceCare.Views.Admins.FieldItemView(params)

        @fields.push fieldItem
      )

  addVariable: (e) ->
    variableName = $(e.target).val()
    @prompt = _(@prompt).splice(@promptCaretPosition, 0, variableName)
    promptArea = @$el.find('.prompt-area')
    promptArea.val(@prompt)
    promptArea.caret(@promptCaretPosition + variableName.length)
    $(e.target).val('')

  destroy: ->
    @section.destroyScriptItemAt(@position)

  destroyFieldItemAt: (position) ->
    @fields[position].remove()
    @fields[position].unbind()
    @fields.splice(position, 1)
    @adjustFieldItemPosition()
    @section.render()

  updateCaretPosition: (e) ->
    @promptCaretPosition = $(e.target).caret() || $(e.target).val().length

  toggleBackground: ->
    @$el.toggleClass('highlight')

  adjustFieldItemPosition: ->
    $.each(@fields, (index, field) ->
      field.setPosition(index)
    )
    @section.render()

  render: ->
    scriptItemHtml = $(@template(prompt: @prompt, type: @scriptType, promptLabel: @promptLabel))
    $.each(@fields, (index, field) =>
      scriptItemHtml.find('.field-items').append(field.render())
    )
    @previewItem()

    scriptItemHtml.find('.field-items').sortable(
      placeholder: 'sortable-placeholder',
      forcePlaceholderSize: 250,
      cursor: 'move',
      handle: '.field-handle',
      start: (event, ui) ->
        ui.item.startPosition = ui.item.index()
      stop: (event, ui) =>
        @moveFieldItemPosition(ui.item.startPosition, ui.item.index())
    )

    @$el.html(scriptItemHtml)

    @enableWhitelistedDuplicateFields()

    # TODO: this is sort of hackish since @enableWhitelistedDuplicateFields doesn't return anything (nothing renders). also @$el.html() doesnt work
    @$el.append('')

  moveFieldItemPosition: (startPosition, endPosition) ->
    movedFieldItem = @fields.splice(startPosition, 1)
    @fields.splice(endPosition, 0, movedFieldItem[0])
    @adjustFieldItemPosition()

  enableWhitelistedDuplicateFields: ->
    existingLabels = _.map($('.field'), (control, index) ->
      $(control).val()
    )

    $.each(existingLabels, (index, label) ->
      labels = _.select(existingLabels, (existingLabel) =>
        existingLabel == label
      )

      if labels.length > 1
        $(".field[value='#{label}']").prop('disabled', false)

    )

  addFieldItem: (e) ->
    e.preventDefault()
    itemType = $(e.target).val()
    params = {scriptItemView: @, type: itemType, position: @fields.length}

    fieldItem = switch itemType
      when 'select', 'radio', 'checkbox'
        new AnsweringServiceCare.Views.Admins.SelectItemView(params)
      else
        new AnsweringServiceCare.Views.Admins.FieldItemView(params)

    @fields.push(fieldItem)
    @render()

  setPosition: (index) ->
    @position = index

  highlightBackground: ->
    @$el.effect('highlight', 1500)

  toHash: ->
    fieldsHashArray = []
    $.each(@fields, (index, field) ->
      fieldsHashArray.push(field.toHash())
    )

    {
      prompt: @getPromptAreaValue(),
      type: @scriptType,
      fields: fieldsHashArray
    }

  getPromptAreaValue: ->
    promptAreaValue = @$el.find('.prompt-area').val()
    if promptAreaValue && promptAreaValue.length > 0
      promptAreaValue
    else
      @prompt

  updatePrompt: (e) ->
    @prompt = $(e.target).val()
    @render()

  renderPreview: ->
    previewTemplate = JST['templates/admins/formRenderer']
    previewTemplate(params: @toHash())

  bindTriggers: ->
    $.each(@fields, (index, field) =>
      fieldHash = field.toHash()
      if fieldHash.triggers
        $.each(fieldHash.triggers, (index, trigger) =>
          $('.form-pane').on('change', "*[name='#{fieldHash.name}']", (e) =>
            if $(e.target).val() == _(trigger.value).underscored()
              @formRenderer.showSections(fieldHash.id, trigger.sections)
          )
        )
    )

  previewItem: ->
    @formBuilder.showPreview()
