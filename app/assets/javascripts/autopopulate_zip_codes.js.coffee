$(document).ready ->
  $("#main-content").on "blur", ".zip-code-lookup", ->
    $.ajax(url: "/zip_codes/find_by_code/" + $(this).val()).done (data) ->
      @template = JST["templates/shared/zipCodeDropdown"](zipCodes: data)
      $("#message_city").replaceWith @template
      $(".zip-code-lookup-state").val(data[0].state).trigger "change"



