$(document).ready ->
  $('#refresh-users').click ->
    $('#follow-users-con').load('/refresh_users')
    return
  return
