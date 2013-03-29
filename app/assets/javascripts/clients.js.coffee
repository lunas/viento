$(document).ready ->
  $('#clients th a, .pagination a, .dropdown-menu a').live('click', ()->
    $.getScript(this.href)
    return false
  )

  # search form
  $('#clients_search input').keyup( (e)->
    if (e.keyCode == 27)
      $('#search').val('')
    $.get( $('#clients_search').attr('action'), $('#clients_search').serialize(), null, 'script')
    return false
  )

  # $('.dropdown-toggle').dropdown()

  $('#messages').fadeOut(6000)

  $('#clients tr td:not([class*=delete])').click (e)->
    url = 'clients/' + $(this).parent().attr('data-client_id') + '/edit'
    window.location = url

  $('#client_sales tr td:not([class*=delete])').click (e)->
    window.location = $(this).parent().attr('data-edit_url')

  if $('.edit_form').size() > 0
    $('.edit_form').validate()

    # table sorter for sales on edit client form
    $('.dataTable').dataTable(
      'iDisplayLength': 10
      "sPaginationType": "full_numbers"
      "sDom": "t<'row'<'span6'lp>>"
      "aaSorting": [[ 6, "desc" ], [0, "asc"]]
      "aoColumnDefs": [{"bSortable": false, "aTargets": [7]}]
    )
