# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  # Sale index

  $('#sales th, .pagination').on('click', 'a', ()->
    $.getScript(this.href)
    history.pushState(null, "", this.href);
    return false
  )

  $('#sales_search').on('change', '#per_page_filter', ()->
    $('#per_page').val( $('#sales_search #per_page_filter').val() )
    submit_form('#sales_search')
    return false
  )

  submit_form = (selector)->
    action   = $(selector).attr('action')
    form_data = $(selector).serialize()
    $.get(action, form_data, null, 'script')
    history.pushState(null, "", action + "?" + form_data)

  $('#sales tr td:not([class*=delete])').click (e)->
    url = 'sales/' + $(this).parent().attr('data-sale_id') + '/edit'
    window.location = url


  # Sale new/edit form

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

  $('#set_date_today a').on('click', (e)->
    today = new Date()
    $('#sale_date_1i').val( today.getFullYear() )
    $('#sale_date_2i').val( today.getMonth()+1 )
    $('#sale_date_3i').val( today.getDate() )
    false
  )

  if $('.sale_form').size() > 0

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

    $('#sale_actual_price').rules("add", {
      required: true
      geld: true
      range: [0, 10000]
      messages: {
        required: "...darf nicht leer sein."
        range: "...muss zwischen 0 und 10 000 liegen"
      }
    })