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

  $('#understate_example #example').change (e)->
    test_value = $(this).val()
    if test_value > $('#settings_understate_threshold').val()
      test_result = test_value/4
    else
      test_result = test_value
    $('#understate_example #example_result').val(test_result)
