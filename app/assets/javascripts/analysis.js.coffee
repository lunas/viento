window.tableLanguageSettings =
  "oPaginate":
    "sNext": "Nächste"
    "sPrevious": "Vorherige"
  "sInfo": "_START_ bis _END_ von _TOTAL_"
  "sInfoFiltered": " - gefiltert aus _MAX_ Zeilen"
  "sLengthMenu": "_MENU_ pro Seite"
  "sSearch": "Filtern:"

$(document).ready ->

  $('#result_collection_filter').on('change', '#collection_filter', ()->
    url = '/analysis/' + $('#criterion').val().replace('by_', '') + '?collection=' + $('#collection_filter').val()
    window.location = url
    return false
  )

  $('table.analysis').dataTable(
    'iDisplayLength': 15
    "sDom": "<'row'<'span12'if>><'row'<'span12't>><'row'<'span12'lp>>"
    'sPaginationType': 'bootstrap'
    'asStripeClasses': []
    "oLanguage": window.tableLanguageSettings
  )

