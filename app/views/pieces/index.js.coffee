$('#pieces').html('<%= escape_javascript(render("pieces")) %>')

$('#collection_filter').val('<%= collection_condition %>')

$('#per_page_filter').val('<%= per_page %>')


$('#pieces tr td:not([class*=delete])').click (e)->
  url = 'pieces/' + $(this).parent().attr('data-piece_id') + '/edit'
  window.location = url

$('#messages').hide()

$('#pieces th a').on('click', ()->
  $.getScript(this.href)
  false
)


