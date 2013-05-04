$ ->
  $("#setpoints_planning").selectable
    filter: ".sel_item",
    stop: (event, ui) ->
      window.mass_assign = {}
      window.mass_assign.ids = $(this).find('.ui-selected').map (i, item) -> $(item).data('id').split("-")
      console.log window.mass_assign.ids
      $('#mass_assign').modal('show')


  $('#mass_assign button[type=submit]').on 'click', () ->
    new_ass = {}
    for date in window.mass_assign.dates
      new_ass["new_#{date}"] = {date: date, hours: hours, task_id: task, project_id: project, _destroy: false}
    data = {user: {id:window.mass_assign.user_id, assignments_attributes: new_ass}}

    $.ajax window.mass_assign.url,
      type: 'PUT'
      data: data
      dataType: 'json'
      success: (data, textStatus, jqXHR) ->
        window.location.reload()

  $('#mass_assign').on 'hide', () ->
    $('.ui-selected').removeClass('ui-selected')


  $('td[rel="popover"]').popover({placement: "top",trigger: "hover",container: 'table', html: 'true'})