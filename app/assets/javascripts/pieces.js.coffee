$(document).ready ->
  $('#pieces th, .pagination').on('click', 'a', ()->
    $.getScript(this.href)
    false
  )
  $('#pieces_search').on('change', '#collection_filter', ()->
    $.get( $('#pieces_search').attr('action'), $('#pieces_search').serialize(), null, 'script')
    return false
  )
  $('#pieces_search').on('change', '#per_page_filter', ()->
    $('#per_page').val( $('#pieces_search #per_page_filter').val() )
    $.get( $('#pieces_search').attr('action'), $('#pieces_search').serialize(), null, 'script')
    return false
  )

  # search form
  $('#pieces_search').keyup('input', (e)->
    searcher.form_selector = '#pieces_search'
    if (e.keyCode == 27)  # ESC
      $('#search').val('')
      searcher.search()      # global searcher obj, defined in clients.js
    else
      searcher.searchTimeout()
  )


  $('#collection_filter').val( $('input#collection').val() )
  $('#per_page_filter').val( $('input#per_page').val() )

  $('.edit_form').validate() if $('.edit_form').length != 0

  $('#pieces tr td:not([class*=delete])').click (e)->
    url = 'pieces/' + $(this).parent().attr('data-piece_id') + '/edit'
    window.location = url

  # piece edit form

  $('#piece_sales tr td:not([class*=delete])').click (e)->
    window.location = $(this).parent().attr('data-edit_url')


  if $('.piece_form').size() > 0
    $('.piece_form').validate()

    $(element).rules("add", {
      required: true
      minlength: 2
      messages: {
        required: "...darf nicht leer sein."
        minlength: "...muss mindestens 2 Zeichen enthalten."
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
      return true if match[2] == undefined # i.e. only one match, like '12'
      year2 = parseInt(match[2].replace('/',''))
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
      required: true
      messages: {
        required: "...darf nicht leer sein."
      }
    })

    # table sorter for sales on edit piece form

    $('#piece_sales.dataTable').dataTable(
      'iDisplayLength': 10
      "sPaginationType": "bootstrap"
      "sDom": "t<'row'<'span6'lp>>"
      #"bJQueryUI": true
      "aaSorting": [[ 3, "desc" ], [0, "asc"]]
      "aoColumnDefs": [{"bSortable": false, "aTargets": [4]}]
      "asStripeClasses": []
      "oLanguage": window.tableLanguageSettings
    )
    # change css classes dataTable will use for sorting:
#    $.extend( $.fn.dataTableExt.oStdClasses, {
#    "sSortAsc": "header headerSortDown",
#    "sSortDesc": "header headerSortUp",
#    "sSortable": "header"
#    } );

