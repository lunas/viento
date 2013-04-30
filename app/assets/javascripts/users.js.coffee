$(document).ready ->

  $('#settings_tabs .nav-tabs a').click (e)->
    e.preventDefault()
    $(this).tab('show')

  $('#settings_tabs .nav-tabs a:first').tab('show')

  $('#users tr td:not([class*=delete])').click (e)->
    url = 'users/' + $(this).parent().attr('data-user_id') + '/edit'
    window.location = url

  $('.user_form').validate(
    rules:
      "user[username]":
        required: true
        minlength: 2
      "user[email]":
        required: true
        email: true
      "user[roles][]":
        required: true
      "user[password]":
        minlength: 6
      "user[password_confirmation]":
        equalTo: "#user_password"
    messages:
      "user[username]":
        required: "Bitte Benutzernamen angeben"
        minlength: "Benutzername muss mind. 2 Zeichen lang sein"
      "user[email]":
        required: "Bitte Email angeben"
        email: "Bitte gueltige Email angeben"
      "user[roles][]":
        required: "Bitte mindestens eine Rolle auswaehlen"
      "user[password]":
        minlength: "Bitte mindestens 6 Zeichen eingeben"
      "user[password_confirmation]":
        equalTo: "Bitte dasselbe Passwort wie oben eingeben"
  )

  $('.new_user_form').validate(
    rules:
      "user[username]":
        required: true
        minlength: 2
      "user[email]":
        required: true
        email: true
      "user[roles][]":
        required: true
      "user[password]":
        minlength: 6
        required: true
      "user[password_confirmation]":
        equalTo: "#user_password"
    messages:
      "user[username]":
        required: "Bitte Benuztername angeben"
        minlength: "Benutztername muss mind. 2 Zeichen lang sein"
      "user[email]":
        required: "Bitte Email angeben"
        email: "Bitte gueltige Email angeben"
      "user[roles][]":
        required: "Bitte mindestens eine Rolle auswaehlen"
      "user[password]":
        minlength: "Bitte mindestens 6 Zeichen eingeben"
        required: "Bitte Passwort angeben"
      "user[password_confirmation]":
        equalTo: "Bitte dasselbe Passwort wie oben eingeben"
  )


  # settings form ////////////

  $('#edit_settings').validate(
    rules:
      "settings[understate_threshold]":
        required: true
        range: [0, 100000]
      "settings[understate_factor]":
        required: true
        range: [1, 20]
    messages:
      "settings[understate_threshold]":
        required: "Bitte einen Schwellenwert angeben"
        range: "Der Wert muss zwischen 0 und 100000 liegen"
      "settings[understate_factor]":
        required: "Bitte einen Teilungsfaktor angegben"
        range: "Der Faktor muss zwischen 1 und 20 liegen"
  )

  update = ->
    return unless $('#edit_settings').valid()
    factor = $('#settings_understate_factor').val()
    return unless parseInt(factor) > 0
    threshold = $('#settings_understate_threshold').val()
    return unless parseInt(threshold) > 0
    test_value = parseInt( $('#understate_example #example').val() )
    if test_value > 0
      if test_value > threshold
        result = test_value/factor
        $('#explanation').text('> ' + threshold).attr('class', 'active')
      else
        result = test_value
        $('#explanation').text('< ' + threshold).attr('class', 'passive')
      $('#understate_example #example_result').val(result)

    $('dd').each ->
      understatement = $(this).find('span:first')
      real_value = parseInt( understatement.next().text().replace(/[()]/g,"") )
      if real_value > threshold
        result = Math.round( real_value/factor )
      else
        result = real_value
      understatement.text(result)

  $('#settings_understate_threshold, #settings_understate_factor, #understate_example #example')
    .change (e)->
      update()
    .keypress (e)->
      k = e.keyCode || e.which
      e.preventDefault() if k == 13

  $('#understate_example button').click (e)->
    $('#example').change()

  #$('button[type=submit]').click (e)->
  #  $('.edit_settings').validate()