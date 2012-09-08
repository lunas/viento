$(document).ready ->
  $('#pieces th a').live('click', ()->
    $.getScript(this.href)
    return false
  )
  $('#pieces_search #collection_filter').on('change', ()->
    $.get( $('#pieces_search').attr('action'), $('#pieces_search').serialize(), null, 'script')
    return false
  )
  $('#pieces_search #per_page_filter').on('change', ()->
    $('#per_page').val( $('#pieces_search #per_page_filter').val() )
    $.get( $('#pieces_search').attr('action'), $('#pieces_search').serialize(), null, 'script')
    return false
  )

  # search form
  $('#pieces_search input').keyup( (e)->
    if (e.keyCode == 27)
      $('#search').val('')
    $.get( $('#pieces_search').attr('action'), $('#pieces_search').serialize(), null, 'script')
    return false
  )

  $('#messages').fadeOut(6000)

  $('.edit_form').validate()

  $('#pieces tr td:not([class*=delete])').click (e)->
    url = 'pieces/' + $(this).parent().attr('data-piece_id') + '/edit'
    window.location = url
