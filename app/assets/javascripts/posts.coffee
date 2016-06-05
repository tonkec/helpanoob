# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  content = $('#content')    # where to load new content
  viewMore = $('#view-more') # tag containing the "View More" link

  isLoadingNextPage = false  # keep from loading two pages at once
  lastLoadAt = null          # when you loaded the last page
  minTimeBetweenPages = 5000 # milliseconds to wait between loading pages
  loadNextPageAt = 1000      # pixels above the bottom

  waitedLongEnoughBetweenPages = ->
    return lastLoadAt == null || new Date() - lastLoadAt > minTimeBetweenPages

  approachingBottomOfPage = ->
    return document.documentElement.clientHeight +
        $(document).scrollTop() < document.body.offsetHeight - loadNextPageAt

  nextPage = ->
    url = viewMore.find('a').attr('href')

    return if isLoadingNextPage || !url

    viewMore.addClass('loading')
    isLoadingNextPage = true
    lastLoadAt = new Date()

    $.ajax({
      url: url,
      method: 'GET',
      dataType: 'script',
      success: ->
        viewMore.removeClass('loading');
        isLoadingNextPage = false;
        lastLoadAt = new Date();
    })

  # watch the scrollbar
  $(window).scroll ->
    if approachingBottomOfPage() && waitedLongEnoughBetweenPages()
      nextPage()

  # failsafe in case the user gets to the bottom
  # without infinite scrolling taking affect.
  viewMore.find('a').click (e) ->
    nextPage()
    e.preventDefault()

  readURL = (file, file_id) ->
    if file
      reader = new FileReader

      reader.onload = (e) ->
        $("##{file_id}").attr 'src', e.target.result
        return

      reader.readAsDataURL file
    return


  $('#show-files').hide()

  $('#fileupload').change ->
    $('#show-files').show()
    customIdPrefix = "image_"
    @files = $(this)[0].files

    i = 0
    while i < @files.length
      customId = customIdPrefix + @files[i].lastModified
      $('#show-files').append("<li class=\"list-group-item\" id=\"upload_prev\">
          <img id=\"" + customId + "\" src=\"#\" alt=\"Post Attach\" height=\"42\" width=\"42\" > " + @files[i].name +
          "</li>")
      # $('#show-files').append("<li class=\"list-group-item\" id=\"upload_prev\">
      #     <img id=\"" + customId + "\" src=\"#\" alt=\"Post Attach\" height=\"42\" width=\"42\" > " + @files[i].name +
      #     " <div class=\"pull-right\"><button type=\"button\" class=\"btn btn-link\" id=\"remove-file\" data-filekey=\"" + @files[i].lastModified + "\">remove</button></div>
      #   </li>")
      readURL(@files[i], customId)
      i++

  $('#show-files').on 'click', 'button#remove-all', ->
    $('input[type=file]').val('')
    $('#show-files').hide()