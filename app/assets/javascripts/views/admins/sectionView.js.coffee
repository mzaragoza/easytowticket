class AnsweringServiceCare.Views.Admins.SectionView extends Backbone.View
  template: JST['templates/admins/section']
  tagName: 'section'
  className: 'form-section'

  events:
    'change .add-plain-script-item' : 'addScriptItem'
    'click .add-section' : 'addSection'
    'click .remove-section' : 'removeSection'
    'keyup .section-name' : 'updateName'
    'change .section-name' : 'updateSectionNames'
    'click .toggle-script-items' : 'toggleScriptItems'

  initialize: (opts) ->
    @formBuilder = opts.formBuilder
    @position = opts.position
    @scriptItems = []
    @condition = opts.condition || {}
    @name = opts.name || ''
    @formRenderer = opts.formRenderer
    @collapsed = false

    if !$.isEmptyObject(opts.script_items)
      @addPreviousScriptItems(opts.script_items)
    else
      psi = new AnsweringServiceCare.Views.Admins.DetailsScriptItemView(formBuilder: @formBuilder, position: 0, section: @)
      @scriptItems.push psi

  updateSectionNames: ->
    @formBuilder.render()

  addPreviousScriptItems: (scriptItemHashes) ->
    $.each(scriptItemHashes, (index, scriptItemHash) =>
      additionalParams = {formBuilder: @formBuilder, position: index, section: @, formRenderer: @formRenderer}
      params = _.extend(scriptItemHash, additionalParams)

      scriptItem = @buildScriptItem(scriptItemHash.type, params)
      @scriptItems.push scriptItem
    )

  highlightBackground: ->
    @$el.effect('highlight', 1500)

  addSection: ->
    @formBuilder.addSection(@position + 1)
    @scrollToSelector('.add-section')

  scrollToSelector: (selector) ->
    selectorPosition = @$el.find(selector).position().top
    viewportHeight = $(window).scrollTop() + $(window).height()
    if selectorPosition > viewportHeight
      $("body").animate(
        scrollTop: @$el.find(selector).position().top,
        0
      )

  removeSection: ->
    @formBuilder.removeSection(@position)

  updateName: (e) ->
    currentNameInput = $(e.target)
    currentName = currentNameInput.val()

    formSectionNames = _.map($('.section-name:not(:focus)'), (sectionName, index) ->
      $(sectionName).val()
    )

    if _.contains(formSectionNames, currentName)
      @errorTooltip = new AnsweringServiceCare.makeTooltip("You already have a section named #{currentName}", 'error')
      @errorTooltip.css(
        left: currentNameInput.position().left + $('#content-wrap').position().left,
        top: currentNameInput.position().top - $(window).scrollTop()
      )
      @errorTooltip.pnotify_display()
    else
      @errorTooltip.pnotify_remove() if @errorTooltip
      @name = currentName

  existingScriptTypes: ->
    _.map(@scriptItems, (scriptItem) ->
      scriptItem.scriptType
    )

  buildScriptItem: (type, params) ->
    viewPrefix = "AnsweringServiceCare.Views.Admins"
    eval("new #{viewPrefix}.#{type}View(params)")

  addScriptItem: (e) ->
    type = $(e.target).val()
    params = {formBuilder: @formBuilder, section: @, position: @scriptItems.length}

    scriptItem = @buildScriptItem(type, params)

    @scriptItems.push(scriptItem)
    @formBuilder.render()
    @scrollToSelector('.add-plain-script-item')
    scriptItem.highlightBackground()

  destroyScriptItemAt: (position) ->
    @scriptItems[position].remove()
    @scriptItems[position].unbind()
    @scriptItems.splice(position, 1)
    @adjustScriptItemPosition()
    @formBuilder.render()

  adjustScriptItemPosition: ->
    $.each(@scriptItems, (index, scriptItem) ->
      scriptItem.setPosition(index)
    )
    @formBuilder.render()

  setPosition: (index) ->
    @position = index

  render: ->
    sectionHtml = $(@template(name: @name, collapsed: @collapsed))
    $.each(@scriptItems, (index, scriptItem) =>
      sectionHtml.filter('.script-items').append(scriptItem.render())
    )

    if @hasDetailScriptItem()
      sectionHtml.find('.remove-section').remove()

    sectionHtml.filter('.script-items').sortable(
      placeholder: 'sortable-placeholder',
      forcePlaceholderSize: 250,
      cursor: 'move',
      handle: '.script-handle',
      start: (event, ui) ->
        ui.item.startPosition = ui.item.index()
      stop: (event, ui) =>
        @moveScriptItemPosition(ui.item.startPosition, ui.item.index())
    )

    if @collapsed
      sectionHtml.filter('.script-items').hide()
    else
      sectionHtml.filter('.script-items').show()

    @$el.html(sectionHtml)

  moveScriptItemPosition: (startPosition, endPosition) ->
    movedScriptItem = @scriptItems.splice(startPosition, 1)
    @scriptItems.splice(endPosition, 0, movedScriptItem[0])
    @adjustScriptItemPosition()

  hasDetailScriptItem: ->
    scriptItemTypes = _.map(@scriptItems, (scriptItem) ->
      scriptItem.scriptType
    )

    _.contains(scriptItemTypes, 'DetailsScriptItem')

  renderPreview: ->
    sectionPreview = JST['templates/admins/sectionPreview']
    sectionPreview(scriptItems: @scriptItems, name: @name, id: _(@name).dasherize())

  bindTriggers: ->
    $.each(@scriptItems, (index, scriptItem) ->
      scriptItem.bindTriggers()
    )

  toggleScriptItems: (e) ->
    e.preventDefault()
    if @collapsed
      $(e.target).removeClass('icon-chevron-left')
      $(e.target).addClass('icon-chevron-down')
    else
      $(e.target).removeClass('icon-chevron-down')
      $(e.target).addClass('icon-chevron-left')
    @collapsed = !@collapsed
    @$el.find('.script-items').toggle()

  toHash: ->
    scriptHashArray = []
    $.each(@scriptItems, (index, scriptItem) ->
      scriptHashArray.push(scriptItem.toHash())
    )

    {
      name: @name,
      script_items: scriptHashArray,
      condition: @condition
    }
