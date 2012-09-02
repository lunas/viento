$('#clients').html('<%= escape_javascript(render("clients")) %>')

$('#status_filter').html('<%= escape_javascript(render("status_filter")) %>')
  .prev().html('<%= params[:status] ? 'Status: ' + params[:status] : 'Status'%><b class="caret"</b>')

$('#role_filter').html('<%= escape_javascript(render("role_filter")) %>')
  .prev().html('<%= params[:role] ? 'Rolle: ' + params[:role] : 'Rolle'%><b class="caret"</b>')

<% if params[:role] == 'all' && params[:status] == 'all' %>
  $('#show_all').hide()
<% else %>
  $('#show_all').show()
<% end %>