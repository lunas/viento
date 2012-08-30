$(document).ready ->
  $('#clients th a, .pagination a').live('click', ()->
    $.getScript(this.href)
    return false
  )

  # search form
  $('#clients_search input').keyup( ->
    $.get( $('#clients_search').attr('action'), $('#clients_search').serialize(), null, 'script')
    return false
  )