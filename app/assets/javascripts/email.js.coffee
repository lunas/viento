jQuery ->
  $('#email').validate(
    rules:
      'email[message]': "required"
    messages:
      'email[message]': "Bitte eine Nachricht eingeben."
  )