$('#clients').html('<%= escape_javascript(render("clients")) %>')

$('#status_filter').html('<%= escape_javascript(render("status_filter")) %>')
  .prev().html('<%= params[:status] ? t("status") + ': ' + params[:status] : 'Status'%><b class="caret"</b>')

$('#role_filter').html('<%= escape_javascript(render("role_filter")) %>')
  .prev().html('<%= params[:role] ? t('role') + ': ' + params[:role] : 'Rolle'%><b class="caret"</b>')

<% if params[:role] == 'all' && params[:status] == 'all' %>
  $('#show_all').hide()
<% else %>
  $('#show_all').show()
<% end %>

$('#per_page_filter').html('<%= escape_javascript(render("per_page_filter")) %>')
.prev().html('<%= params[:per_page] ? t('per_page') + ': ' + params[:per_page] : 'Pro Seite'%><b class="caret"</b>')

$('#messages').hide()

$('#clients tr td:not([class*=delete])').click (e)->
  url = 'clients/' + $(this).parent().attr('data-client_id') + '/edit'
  window.location = url

$('#clients th, .pagination').on('click', 'a', ()->
  $.getScript(this.href)
  false
)
