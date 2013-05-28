$('#sales').html('<%= escape_javascript(render("sales")) %>')

$('#per_page_filter').val('<%= per_page %>')

$('#sales tr td:not([class*=delete])').click (e)->
  url = 'sales/' + $(this).parent().attr('data-sale_id') + '/edit'
  window.location = url

$('#messages').hide()

$('#sales th, .pagination').on('click', 'a', ()->
  $.getScript(this.href)
  return false
)

$('tr').hover( ->
  $(this).find('td').toggleClass('active-row')
)
