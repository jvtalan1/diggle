$(document).ready ->
  $('#refresh-users').click ->
    $('#follow-users-con').load('/refresh_users')
    return

  currPage = 1
  $('a.next').click ->
    loadMore ++currPage
    return
  return

loadMore = (pageNo) ->
  url = '?page=' + pageNo
  $('a.next').attr('href', url)
  return
