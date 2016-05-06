$(document).ready ->
  $notifications_dropdow = $('#notifications-dropdow')
  new_notification_pooling = undefined

  clear_polling = ->
    clear_interval new_notification_pooling
    $document.off 'page:change', clear_polling
    return

  fetch_new_notifications = ->
    lastID = $('.dropdown-menu li:eq(1)').attr('id')
    $.ajax
      url: '/notifications/unread'
      type: 'GET'
      data:
        lastID: lastID

    return

  if $notifications_dropdow.length
    new_notification_pooling = setInterval(fetch_new_notifications, 5000)
    $(document).on 'page:change', clear_polling
  return