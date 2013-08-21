$(document).ready ->

  $('#clients th, .pagination, .dropdown-menu').on('click', 'a', ()->
    $.getScript(this.href)
    history.pushState(null, "", this.href);
    false
  )

  $('#clients_search').on('change', '#per_page_filter', ()->
    $('#per_page').val( $('#clients_search #per_page_filter').val() )
    submit_form()
    false
  )
  $('#clients_search').on('change', '#status_filter', ()->
    $('#status').val( $('#clients_search #status_filter').val() )
    submit_form()
    false
  )
  $('#clients_search').on('change', '#role_filter', ()->
    $('#role').val( $('#clients_search #role_filter').val() )
    submit_form()
    false
  )
  $('#clients_search').on('change', '#mailing_filter', ()->
    $('#mailing').val( $('#clients_search #mailing_filter').val() )
    submit_form()
    false
  )


  submit_form = ->
    action   = $('#clients_search').attr('action')
    form_data = $('#clients_search').serialize()
    $.get(action, form_data, null, 'script')
    history.pushState(null, "", action + "?" + form_data)

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
      action = $(@form_selector).attr('action')
      data   = $(@form_selector).serialize()
      $.get( action, data, null, 'script')
      history.pushState(null, "", action + "?" + data)
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

  $('#client_mailing').tooltip(
    title: ->
      target = $('#client_mailing')
      if target.val() == 'private'
        return $('#client_phone_home').val()
      if target.val() == 'work'
        return $('#client_phone_work').val()
      if target.val() == 'work'
        return $('#client_phone_work').val()
      if target.val() == 'mobile'
        return $('#client_phone_mobile').val()
      if target.val() == 'email'
        return $('#client_email').val()
      return ''
    trigger: 'hover'
    placement: 'right'
  )
  .on('change', (e)->
    $('#client_mailing').tooltip('show')
  )

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
