
$(document).ready ->

  # table sorter for sales on edit client form
  $('#revenue_table').dataTable(
    'iDisplayLength': 100
    'bPaginate': false
    'sDom': 't'
    "aaSorting": [[0, "desc"]]
    "asStripeClasses": []
  )

  $('#start_image').mouseover (event) ->
    $('#start_image').slider
      value: $('#start_image img').css('opacity') * 100
      slide: (event, ui) ->
        $('#start_image img').css('opacity', ui.value/100 )
  .mouseleave (event) ->
    $('#start_image').slider('destroy')


  # general functions

  $(document).ajaxStart(->
    $('#ajax-loader').show()
  )
  .ajaxStop(->
    $('#ajax-loader').hide()
  )
