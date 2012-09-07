$('#pieces').html('<%= escape_javascript(render("pieces")) %>')

$('#collection_filter').val('<%= params[:collection_filter] %>')

$('#per_page_filter').val('<%= params[:per_page] %>')

attach_open_piece()

$('#messages').hide()
