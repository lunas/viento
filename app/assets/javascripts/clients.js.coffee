$(document).ready ->

  $('#clients th, .pagination, .dropdown-menu').on('click', 'a', ()->
    $.getScript(this.href)
    false
  )


# search form

  window.searcher =   # make it global by attaching it to window
    delay: 300
    term: null
    form_selector: ''
    searchTimeout: ( event )->
      clearTimeout( @searching );
      that = this
      this.searching = setTimeout( ->
        # only search if the value has changed
        input_val = $('#search').val()
        if that.term != input_val
          that.term = input_val
          that.search()
      , @delay )
    search: ->
      $.get( $(@form_selector).attr('action'), $(@form_selector).serialize(), null, 'script')
      @term = ''

  $('#clients_search').keyup('input', (e)->
    searcher.form_selector = '#clients_search'
    if (e.keyCode == 27)  # ESC
      $('#search').val('')
      searcher.search()
    else
      searcher.searchTimeout()
    if $(e.target).val()==''
      $(e.target).next().hide()
    else
      $(e.target).next().show().css('display', 'inline-block')
  )
  $('#clients_search .add-on').on('click', (e)->
    $('#search').val('')
    searcher.search()
    $('#search').next().hide()
  ).find('a').hover (e)->
    $(e.target).tooltip()

  $('.dropdown-toggle').dropdown()

  $('#flash_messages .fadeout').fadeOut(8000)

  $('#clients tr td:not([class*=delete])').click (e)->
    url = 'clients/' + $(this).parent().attr('data-client_id') + '/edit'
    window.location = url

  $('#client_sales tr td:not([class*=delete])').click (e)->
    window.location = $(this).parent().attr('data-edit_url')

  $('#clients .table .phone').hover (e)->
    $(this).find('.others').toggle()

  # client edit

  if $('.edit_form').size() > 0
    $('.edit_form').validate(
      rules:
        "client[last_name]":
          required: true
      messages:
        "client[last_name]":
          required: 'Bitte einen Nachnamen angeben'
    )

    # table sorter for sales on edit client form
    $('#client_sales.sales_table').dataTable(
      'iDisplayLength': 15
      "sPaginationType": "bootstrap"
      "sDom": "t<'row'<'span7'lp>>"
      "aaSorting": [[ 6, "desc" ], [0, "asc"]]
      "aoColumnDefs": [{"bSortable": false, "aTargets": [7]}]
      "asStripeClasses": []
      "oLanguage": window.tableLanguageSettings
    )
