class AnsweringServiceCare.Views.Admins.FieldItemView extends Backbone.View
  template: JST['templates/admins/fieldItem']
  tagName: 'div'
  className: 'field-item'

  fieldItemEvents:
    'keyup .field' : 'updateLabel'
    'change .field' : 'renderScriptItem'
    'click .required' : 'toggleRequire'
    'click .close-field' : 'destroy'
    'click .notify-sms' : 'toggleNotifySms'
    'click .notify-email' : 'toggleNotifyEmail'

  extraEvents: {}

  events: ->
    _.extend({}, @fieldItemEvents, @extraEvents)

  initialize: (opts) ->
    @type = opts.type
    @label = opts.label || ''
    @dataSource = opts.dataSource || []
    @typeWhitelist = ['details', 'recipient_select', 'phone_number', 'local', 'extension', 'mobile', 'alt_phone', 'first_name', 'last_name', 'company_name', 'email', 'address', 'address2', 'zip', 'city', 'state', 'emergency', 'referer', 'content', 'user_id', 'is_emergency', 'how_you_hear_about_us']
    @required = opts.required || false
    @options = opts.options || {notifySms: false, notifyEmail: false}
    @position = opts.position

    if @type == 'recipient_select'
      @label = 'For'
    @scriptItemView = opts.scriptItemView

  render: ->
    fieldItemHtml = $(@template(disabled: @inWhitelist(), required: @required, label: @label, type: @type, options: @options))

    @$el.html(fieldItemHtml)

  renderScriptItem: ->
    @scriptItemView.render()

  destroy: ->
    @scriptItemView.destroyFieldItemAt(@position)

  setPosition: (index) ->
    @position = index

  updateLabel: (e) ->
    currentField = $(e.target)
    currentLabel = $(e.target).val()

    if @isExistingFieldName(currentLabel)
      @errorTooltip = AnsweringServiceCare.makeTooltip("A field with the same label/name (#{@label}) already exists.", 'error')

      scriptItemX = $('#content-wrap').position().left
      scriptItemY = @scriptItemView.$el.find('.field-type-select').position().top - $(window).scrollTop()

      @errorTooltip.css(
        left: scriptItemX,
        top: scriptItemY
      )

      @errorTooltip.pnotify_display()
    else
      @errorTooltip.pnotify_remove() if @errorTooltip
      @label = currentLabel

  toggleRequire: ->
    @required = !@required
    @scriptItemView.render()

  toggleNotifySms: ->
    @options.notifySms = !@options.notifySms
    @scriptItemView.render()

  toggleNotifyEmail: ->
    @options.notifyEmail = !@options.notifyEmail
    @scriptItemView.render()

  underscoredFieldName: ->
    switch @type
      when 'recipient_select'
        'user_id'
      when 'emergency'
        'is_emergency'
      when 'referer'
        'how_you_hear_about_us'
      when 'details'
        'content'
      when 'address2'
        'address2'
      else
        _(@label.replace('/ /g', '')).underscored()

  fieldName: ->
    if @inWhitelist()
      "message[#{@underscoredFieldName()}]"
    else
      "message[answers][#{@underscoredFieldName()}]"

  fieldId: ->
    "message_#{@underscoredFieldName()}"

  inWhitelist: ->
    _.contains(@typeWhitelist, @underscoredFieldName())

  isExistingFieldName: (fieldName) ->
    existingLabels = _.map($('.field:not(:focus)'), (control, index) ->
      $(control).val()
    )

    _.contains(existingLabels, fieldName) && fieldName != ''

  toHash: ->
    {
      label: @label,
      type: @type,
      options: @options,
      name: @fieldName(),
      id: @fieldId(),
      dataSource: @dataSource,
      required: @required
    }
