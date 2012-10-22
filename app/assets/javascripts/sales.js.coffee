# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.sale_form input#sale_client_name_and_city').autocomplete
    source: "/clients/find"
    minLength: 1
    focus: ( event, ui )->
      $( "#sale_client_name_and_city" ).val( ui.item.label )
      return false
    select: ( event, ui )->
      $( "#sale_client_name_and_city" ).val( ui.item.label )
      $( "#sale_client_id" ).val( ui.item.id)
      return false

  $('.sale_form input#sale_piece_info').autocomplete
    source: "/pieces/find"
    minLength: 1
    focus: ( event, ui )->
      $( "#sale_piece_info" ).val( ui.item.label )
      $( "#sale_actual_price" ).val( ui.item.price )
      return false
    select: ( event, ui )->
      $( "#sale_piece_info" ).val( ui.item.label )
      $( "#sale_actual_price" ).val( ui.item.price )
      $( "#sale_piece_id" ).val( ui.item.id)
      return false

