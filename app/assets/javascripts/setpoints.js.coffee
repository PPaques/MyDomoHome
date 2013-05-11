$ ->
  $("#setpoints_planning").selectable
    filter: ".sel_item",
    stop: (event, ui) ->
      window.mass_assign_ids = {}
      $(this).find('.ui-selected').map (i, item) ->
        for key, value of $(item).data('id')
          if typeof(window.mass_assign_ids[key]) == "undefined"
            window.mass_assign_ids[key] = []
          window.mass_assign_ids[key].push value

      $('#mass_assign').modal('show')

  $('#mass_assign .submit').on 'click', () ->
    url = $("#mass_assign").data("url")
    temperatures = {}
    data_values = {}
    # we take all the temperature on the webpage
    $.each window.room_id, (index,value) ->
      temperatures[value] = $('#mass_assign input[id="room_temperature_'+value+'"]').val() if $('#mass_assign input[id="room_temperature_'+value+'"]').val()? and $('#mass_assign input[id="room_temperature_'+value+'"]').val() != ""
    # we make a array with setpoint_id, temperature
    for room_id, setpoint_ids of window.mass_assign_ids
      $.each setpoint_ids,(index, setpoint_id) ->
        data_values[setpoint_id[0]] = temperatures[room_id] if temperatures[room_id] != ""

    data = {setpoints_update: data_values}
    $.ajax url,
      type: 'PUT'
      data: data
      dataType: 'json'
      success: (data, textStatus, jqXHR) ->
        window.location.reload()
      error: (data, textStatus, jqXHR)->
        alert("Température incorrecte")

  $('#mass_assign').on 'hide', () ->
    $('.ui-selected').removeClass('ui-selected')


  $('td[rel="popover"]').popover({placement: "top",trigger: "hover",container: 'table', html: 'true'})

