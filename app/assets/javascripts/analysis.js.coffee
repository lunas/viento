window.tableLanguageSettings =
  "oPaginate":
    "sNext": "Nächste"
    "sPrevious": "Vorherige"
  "sInfo": "_START_ bis _END_ von _TOTAL_"
  "sInfoFiltered": " - gefiltert aus _MAX_ Zeilen"
  "sLengthMenu": "_MENU_ pro Seite"
  "sSearch": "Filtern:"

$(document).ready ->

  $('table.analysis').dataTable(
    'iDisplayLength': 15
    "sDom": "<'row'<'span12'if>><'row'<'span12't>><'row'<'span12'lp>>"
    'sPaginationType': 'bootstrap'
    'asStripeClasses': []
    "oLanguage": window.tableLanguageSettings
  )

