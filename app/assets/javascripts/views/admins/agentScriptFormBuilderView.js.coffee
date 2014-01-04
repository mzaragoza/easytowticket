class AnsweringServiceCare.Views.Admins.AgentScriptFormBuilderView extends Backbone.View
  events:
    'click #save-script' : 'saveAgentScript'
    'click .add-section' : 'insertSectionToTop'

  initialize: (opts) ->
    @$el = $('#agent-script')
    @sections = []
    @uniqueScriptTypes = ['PatchInstructionsScriptItem', 'OpeningMessageScriptItem', 'ClosingMessageScriptItem', 'CallControlScriptItem', 'EmergencyScriptItem', 'RefererScriptItem', 'DetailsScriptItem']
    @sectionNames = []

    if !$.isEmptyObject(opts.form)
      @sectionNames = _.map(opts.form, (sectionHash) ->
        sectionHash.name
      )
      @addPreviousSections(opts.form)
    else
      psi = new AnsweringServiceCare.Views.Admins.SectionView(formBuilder: @, position: 0)
      @sections.push psi

    @formRenderer = new AnsweringServiceCare.Views.Admins.FormRendererView(sections: @sections)

    @setupPreviewScrolling()
    @showLegendOfVariables()
    @showFormInstructions()
    @render()

  showLegendOfVariables: ->
    legend = $.pnotify
      title: 'VARIABLE LEGEND'
      text: JST['templates/admins/variableLegend']().replace(/\n/g,'')
      icon: 'icon-list'
      hide: false
      type: 'info'

    legend.pnotify_display()

  showFormInstructions: ->
    formInstructions = $.pnotify
      title: 'FORM INSTRUCTIONS'
      text: JST['templates/admins/formInstructions']().replace(/\n/g,'')
      icon: 'icon-list'
      hide: false
      type: 'info'

    formInstructions.pnotify_display()
    $('#form-instructions').accordion(
      collapsible: true
      heightStyle: 'content'
    )

  setupPreviewScrolling: ->
    $('.form-pane').affix()

    $(window).scroll ->
      formPaneY = $('.form-pane').position().top
      bottomOffset = $(window).height() - formPaneY

      # TODO: Take out magic number
      $('.form-pane').height(bottomOffset - 100)

  insertSectionToTop: (e) ->
    e.preventDefault()
    @addSection(0)

  addSection: (position) ->
    newSection = new AnsweringServiceCare.Views.Admins.SectionView(formBuilder: @, position: position, script_items: [{type: 'PlainScriptItem', fields: [], prompt: ''}])
    @sections.splice(position, 0, newSection)
    @adjustSectionPosition()
    newSection.highlightBackground()

  removeSection: (position) ->
    @sections[position].remove()
    @sections[position].unbind()
    @sections.splice(position, 1)
    @adjustSectionPosition()

  adjustSectionPosition: ->
    $.each(@sections, (index, section) ->
      section.setPosition(index)
    )

    @render()

  addPreviousSections: (sectionHashes) ->
    unless $.isEmptyObject(sectionHashes)
      $.each(sectionHashes, (index, sectionHash) =>
        params = _.extend(sectionHash, formBuilder: @, position: index)
        @sections.push new AnsweringServiceCare.Views.Admins.SectionView(params)
      )

  disableUniqueSelectOptions: ->
    existingScriptTypes = _.map(@sections, (section) ->
      section.existingScriptTypes()
    )
    $.each(_.intersection(@uniqueScriptTypes, _.flatten(existingScriptTypes)), (index, blacklistedType) =>
      $("option[value=#{blacklistedType}]").prop('disabled', true)
    )

  render: ->
    $.each(@sections, (index, section) =>
      @$el.find('.form-sections').append(section.render())
    )
    $('.add-plain-script-item option').prop('disabled', false)

    $('.form-sections').sortable(
      placeholder: 'sortable-placeholder',
      forcePlaceholderSize: 500,
      cursor: 'move',
      handle: '.section-handle',
      start: (event, ui) ->
        ui.item.startPosition = ui.item.index()
      stop: (event, ui) =>
        @moveSectionPosition(ui.item.startPosition, ui.item.index())
    )

    @disableUniqueSelectOptions()

  moveSectionPosition: (startPosition, endPosition) ->
    movedSection = @sections.splice(startPosition, 1)
    @sections.splice(endPosition, 0, movedSection[0])
    @adjustSectionPosition()

  showPreview: ->
    @formRenderer.render()

  toJSON: ->
    sectionHashes = []
    $.each(@sections, (index, section) ->
      sectionHashes.push(section.toHash())
    )

    JSON.stringify({form: sectionHashes})

  saveAgentScript: ->
    @$el.find('#phone_agent_script').val(@toJSON())
