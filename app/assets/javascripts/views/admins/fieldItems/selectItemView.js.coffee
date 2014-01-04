class AnsweringServiceCare.Views.Admins.SelectItemView extends AnsweringServiceCare.Views.Admins.FieldItemView
  template: JST['templates/admins/fieldItems/selectItem']

  extraEvents:
    'click .add-option' : 'addSelectOption'

  initialize: (opts) ->
    super(opts)
    @selectOptions = []

    if !$.isEmptyObject(opts.dataSource)
      $.each(opts.dataSource, (index, option) =>
        @addPreviousOptions(option, opts.triggers[index].sections)
      )
    else
      @selectOptions = [new AnsweringServiceCare.Views.Admins.OptionItemView(scriptItemView: @scriptItemView)]

    @render()

  addPreviousOptions: (option, sections) ->
    @selectOptions.push(
      new AnsweringServiceCare.Views.Admins.OptionItemView(
        scriptItemView: @scriptItemView,
        name: option[0],
        value: option[1],
        sections: sections
      )
    )

  addSelectOption: (e) ->
    @selectOptions.push new AnsweringServiceCare.Views.Admins.OptionItemView(scriptItemView: @scriptItemView)
    @scriptItemView.render()

  addOptionsToDataSource: ->
    answers = []
    $.each(@selectOptions, (index, option) =>
      answers.push [option.name, _(option.name).underscored()]
    )
    @dataSource = answers

  render: ->
    @addOptionsToDataSource()
    selectHtml = $(@template(disabled: false, label: @label, type: @type, options: @options, required: @required))
    $.each(@selectOptions, (index, optionItem) =>
      selectHtml.find('.add-option').before(optionItem.render())
    )

    @$el.html(selectHtml)


  toHash: ->
    selectHash = _.map(@selectOptions, (selectOption) ->
      selectOption.toHash()
    )
    _.extend(super(), triggers: selectHash)
