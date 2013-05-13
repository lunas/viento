$(document).ready ->

  $('#clients th, .pagination, .dropdown-menu').on('click', 'a', ()->
    $.getScript(this.href)
    false
  )

#  key_up_time_stamp = null
#  min_time_between_keys = 100
#  enough_time_passed = ->
#    return true unless key_up_time_stamp?
#
#
#  now = ->
#    new Date().getTime()

  # search form
  $('#clients_search').keyup('input', (e)->
    if (e.keyCode == 27)  # ESC
      $('#search').val('')
      esc = true

    num_chars = $('#search').val().length
    if esc or num_chars == 0 or num_chars > 1
      $.get( $('#clients_search').attr('action'), $('#clients_search').serialize(), null, 'script')
    false
  )

  $('.dropdown-toggle').dropdown()

  $('#flash_messages .fadeout').fadeOut(8000)

  $('#clients tr td:not([class*=delete])').click (e)->
    url = 'clients/' + $(this).parent().attr('data-client_id') + '/edit'
    window.location = url

  $('#client_sales tr td:not([class*=delete])').click (e)->
    window.location = $(this).parent().attr('data-edit_url')

  if $('.edit_form').size() > 0
    $('.edit_form').validate(
      rules:
        "client[last_name]":
          required: true
      messages:
        "client[last_name]":
          required: 'Bitte einen Nachnamen angeben'
    )

    # table sorter for sales on edit client form
    $('#client_sales.sales_table').dataTable(
      'iDisplayLength': 15
      "sPaginationType": "bootstrap"
      "sDom": "t<'row'<'span7'lp>>"
      "aaSorting": [[ 6, "desc" ], [0, "asc"]]
      "aoColumnDefs": [{"bSortable": false, "aTargets": [7]}]
      "asStripeClasses": []
      "oLanguage": window.tableLanguageSettings
    )
