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


  # piece edit form
  if $('.piece_form').size() > 0
    $('.piece_form').validate()


    $(element).rules("add", {
      required: true
      minlength: 2
      messages: {
        required: "...darf nicht leer sein."
        minlength: "...muss mindestens 2 Buchstaben enthalten."
      }
    }) for element in ['#piece_name', '#piece_fabric', '#piece_color']

    $('#piece_size').rules("add", {
      required: true
      range: [30, 44]
      messages: {
        required: "...darf nicht leer sein."
        range: "...muss zwischen 30 und 44 liegen."
      }
    })
    $('#piece_count_produced').rules("add", {
      required: true
      range: [0, 1000]
      messages: {
        required: "...darf nicht leer sein."
        range: "...muss zwischen 0 und 1000 liegen."
      }
    })

    jQuery.validator.addMethod "kollektion", ((value, element) ->
      match = value.match(/^(\d\d)(\/\d\d)?$/)
      return false if match == null
      year1 = parseInt(match[1])
      year2 = parseInt(match[2].replace('/',''))
      return true if isNaN(year2) # i.e. only one match, like '12'
      return true if year2 - year1 == 1
      return false
    ), "Kollektion muss entweder die Form '12' oder '12/13' haben."

    jQuery.validator.addMethod "geld", ((value, element) ->
      return value.match(/^\d+(\.?\d[05])?$/)
    ), "Muss ein Geldbetrag der Form '600' oder '600.00' oder '600.25' sein."

    $('#piece_preis').rules("add", {
      required: true
      geld: true
      range: [0, 10000]
      messages: {
        required: "...darf nicht leer sein."
        range: "...muss zwischen 0 und 10 000 liegen"
      }
    })
    $('#piece_kosten').rules("add", {
    required: true
    geld: true
    range: [0, 10000]
    messages: {
    required: "...darf nicht leer sein."
    range: "...muss zwischen 0 und 10 000 liegen"
    }
    })

    $('#piece_collection').rules("add", {
      kollektion: true
    })

    # table sorter for sales on edit piece form

    $('#piece_sales').tablesorter(
      {sortList: [[3,0]]}
    ).tablesorterPager({container: $(".tablesorter-pager"), size: 10});