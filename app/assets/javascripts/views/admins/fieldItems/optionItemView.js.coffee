class AnsweringServiceCare.Views.Admins.OptionItemView extends Backbone.View
  template: JST['templates/admins/fieldItems/optionItem']

  events: ->
    'click .add-trigger' : 'showTriggers'
    'click .checkbox-trigger' : 'updateSections'

  initialize: (opts={}) ->
    @name = opts.name || ''
    @value = opts.value || ''
    @scriptItemView = opts.scriptItemView
    @$el.attr(type: 'text', required: true)
    @sections = opts.sections || []

    # TODO: better check for null
    @sectionsToTrigger = if opts.scriptItemView.formBuilder && opts.scriptItemView.formBuilder.sectionNames
      _.reject(opts.scriptItemView.formBuilder.sectionNames, (sectionName) ->
        opts.scriptItemView.section.name == sectionName
      )
    else
      []

    @$el.on('change', '.field-option', (e) =>
      @updateName(e)
      fieldOption = $(e.target)
      fieldOption.prop('disabled', (fieldOption.val() == ''))
    )

  updateSections: (e) ->
    checkbox = $(e.target)
    if checkbox.is(':checked')
      @sections.push checkbox.val()
    else
      @sections = _.reject(@sections, (section) =>
        section == checkbox.val()
      )

  updateName: (e) ->
    @name = $(e.target).val()
    @scriptItemView.render()

  # TODO: clean this up
  updateSectionsToTrigger: ->
    currentSections = _.map(@$el.parents('.form-section').siblings().find('.section-name'), (section) ->
      $(section).val()
    )

    if currentSections.length > 0
      removedSections = _.difference(@sectionsToTrigger, currentSections)
      newSections = _.difference(currentSections, @sectionsToTrigger)

      if removedSections.length > 0
        @sectionsToTrigger = _.without(@sectionsToTrigger, removedSections...)
        @sections = _.without(@sections, removedSections...)
      else if newSections.length > 0
        @sectionsToTrigger.push newSections...

  render: ->
    @updateSectionsToTrigger()

    optionHtml = $(@template(name: @name, sections: @sections, sectionsToTrigger: @sectionsToTrigger))

    optionHtml.find('.add-trigger').prop('disabled', (optionHtml.find('.field-option').val() == ''))

    if @sections.length > 0 || @sectionsToTrigger.length == 0
      optionHtml.find('.add-trigger').prop('disabled', true)
    else
      optionHtml.filter('.sections-to-trigger').hide()

    @$el.html(optionHtml)

  showTriggers: (e) ->
    e.preventDefault()
    @$el.find('.sections-to-trigger').show()
    $(e.target).prop('disabled', true)

  toHash: ->
    {
      value: @name,
      sections: @sections
    }
