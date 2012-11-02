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

  if $('.sale_form').size() > 0

    $('input.datepicker').change( (event) ->
      if $('.sale_form').valid()
        $('input.date-alt').val( $(this).val() )
    )

    $('.sale_form').validate()

    jQuery.validator.addMethod "geld", ((value, element) ->
      return value.match(/^\d+(\.?\d[05])?$/)
    ), "Muss ein Geldbetrag der Form '600' oder '600.00' oder '600.25' sein."

    $(element).rules("add", {
      required: true
      messages: {
        required: "...darf nicht leer sein."
      }
    }) for element in ['#sale_client_name_and_city', '#sale_piece_info']

    $('#sale_date').rules("add", {
      date: true
      messages: {
        date: "...muss ein gueltiges Datum sein."
      }
    })

    $('#sale_actual_price').rules("add", {
      required: true
      geld: true
      range: [0, 10000]
      messages: {
        required: "...darf nicht leer sein."
        range: "...muss zwischen 0 und 10 000 liegen"
      }
    })