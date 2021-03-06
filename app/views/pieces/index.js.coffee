$('#pieces').html('<%= escape_javascript(render("pieces")) %>')

$('#collection_filter').val('<%= collection_condition %>')

$('#per_page_filter').val('<%= per_page %>')


$('#pieces tr td:not([class*=delete])').click (e)->
  url = 'pieces/' + $(this).parent().attr('data-piece_id') + '/edit'
  window.location = url

$('#messages').hide()

$('#pieces th, .pagination').on('click', 'a', ()->
  $.getScript(this.href)
  history.pushState(null, "", this.href);
  false
)

$('#collection_filter').val( $('input#collection').val() )
$('#per_page_filter').val( $('input#per_page').val() )

$('tr').hover( ->
  $(this).find('td').toggleClass('active-row')
)
