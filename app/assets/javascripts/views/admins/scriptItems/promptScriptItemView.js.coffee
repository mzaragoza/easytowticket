class AnsweringServiceCare.Views.Admins.PromptScriptItemView extends AnsweringServiceCare.Views.Admins.PlainScriptItemView
  template: JST['templates/admins/scriptItems/promptScriptItem']

  initialize: (opts) ->
    super(opts)
    @scriptType = 'PromptScriptItem'
    @hasBlurEvent = false

    $.fn.wysihtml5.locale.en.emphasis = {
      bold: 'B',
      italic: 'I',
      underline: 'U'
    }

    $.fn.wysihtml5.locale.en.font_styles = {
      normal: 'normal',
      h1: 'H1',
      h2: 'H2',
      h3: 'H3',
      h4: 'H4',
      h5: 'H5',
      h6: 'H6'
    }

  addVariable: (e) ->
    variableName = $(e.target).val()
    @prompt = _(@prompt).splice(@promptCaretPosition, 0, variableName)
    @wysihtml5Editor.setValue(@prompt)
    $(e.target).val('')

  render: ->
    scriptItemFieldName = _(_(@scriptType).splice(-10, 10)).underscored()
    scriptItemHtml = $(@template(prompt: @prompt, promptLabel: @promptLabel, scriptItemFieldName: scriptItemFieldName))
    @previewItem()
    @$el.html(scriptItemHtml)

    unless @hasBlurEvent
      @$el.on('blurredFromWysihtml5', '.wysihtml5', (e) =>
        @prompt = $(e.target).val()
        @promptCaretPosition = @wysihtml5Editor.composer.selection.getRange().endOffset
        @previewItem()
      )
      @hasBlurEvent = true

    wysihtml5Textarea = @$el.find('.wysihtml5').wysihtml5({
      'image':false,
      'color':true,
      'size': 'small',
      'lists' : false,
      'link': false,
      'events': {
        'blur': ->
          $(@.textareaElement).trigger('blurredFromWysihtml5')
      }
    })
    @wysihtml5Editor = wysihtml5Textarea.data('wysihtml5').editor

    @$el.append('')
