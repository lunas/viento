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

  $('.dropdown-toggle').dropdown()
