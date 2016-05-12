$(document).ready ->
  $messages_dropdow = $('#messages-dropdown')
  new_messages_polling = undefined

  clear_polling = ->
    clear_interval new_messages_polling
    $document.off 'page:change', clear_polling
    return

  fetch_new_messages = ->
    $.ajax
      url: '/messages/unread'
      type: 'GET'

    return

  if $messages_dropdow.length
    new_messages_polling = setInterval(fetch_new_messages, 5000)
    $(document).on 'page:change', clear_polling
  return