$(document).ready ->
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