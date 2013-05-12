$ ->
  $('.slider').slider
    range: "min"
    min: 0
    max: 100
    step: 1
    value: $("#light_threeshold_hidden").val()
    slide: (event, ui) ->
      $(".light_threeshold_percentage").text ui.value+"%"
      $("#light_threeshold_hidden").val ui.value