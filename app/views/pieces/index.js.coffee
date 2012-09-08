$('#pieces').html('<%= escape_javascript(render("pieces")) %>')

$('#collection_filter').val('<%= collection_condition %>')

$('#per_page_filter').val('<%= per_page %>')

attach_open_piece()

$('#messages').hide()
