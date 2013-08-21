$('#clients').html('<%= escape_javascript(render("clients")) %>')

$('#messages').hide()

$('#clients tr td:not([class*=delete])').click (e)->
  url = 'clients/' + $(this).parent().attr('data-client_id') + '/edit'
  window.location = url

$('#clients th, .pagination').on('click', 'a', ()->
  $.getScript(this.href)
  history.pushState(null, "", this.href);
  false
)

$('tr').hover( ->
  $(this).find('td').toggleClass('active-row')
)