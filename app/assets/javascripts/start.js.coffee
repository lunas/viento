
$(document).ready ->

  # table sorter for sales on edit client form
  $('#revenue_table').dataTable(
    'iDisplayLength': 100
    'bPaginate': false
    'sDom': 't'
    "aaSorting": [[0, "desc"]]
    "asStripeClasses": []
  )

  $('#revenue_table tr').click (e)->
    url = 'pieces?collection_filter=' + $(this).attr('data-collection')
    window.location = url

  $('#start_image').mouseover (event) ->
    $('#start_image').slider
      value: $('#start_image img').css('opacity') * 100
      slide: (event, ui) ->
        $('#start_image img').css('opacity', ui.value/100 )
  .mouseleave (event) ->
    $('#start_image').slider('destroy')

  $('#start_image span').click (e)->
    $('#revenue_table .revenue').toggle()
    #$('#revenue_table tr td:last-child, #revenue_table tr th:last-child').toggle()

  # general functions

  $(document).ajaxStart(->
    $('#ajax-loader').show()
  )
  .ajaxStop(->
    $('#ajax-loader').hide()
  )

  $('tr').hover( ->
    $(this).find('td').toggleClass('active-row')
  )

