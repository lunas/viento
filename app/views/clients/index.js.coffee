$('#clients').html('<%= escape_javascript(render("clients")) %>')

$('#status_filter').html('<%= escape_javascript(render("status_filter")) %>')
$('#role_filter').html('<%= escape_javascript(render("role_filter")) %>')

