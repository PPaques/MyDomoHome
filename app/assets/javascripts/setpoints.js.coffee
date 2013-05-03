$ ->
  $("#setpoints_planning").selectable
    filter: ".sel_item",
    stop: (event, ui) ->
      window.mass_assign = {}
      window.mass_assign.dates = $(this).find('.ui-selected').map (i, item) -> $(item).data('time')
      console.log window.mass_assign.dates
      $('#mass_assign').modal('show')