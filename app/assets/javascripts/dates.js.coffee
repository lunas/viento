$ ->
  $("input.datepicker").each (i) ->
    $(this).datepicker
      altFormat: "yy-mm-dd"
      dateFormat: "dd.mm.yy"
      altField: $(this).next()
      changeYear: true
      yearRange: "1986:+1"
      constrainInput: true
      dayNamesMin: ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So']
      minDate: '01.01.1986'
      maxDate: 365
