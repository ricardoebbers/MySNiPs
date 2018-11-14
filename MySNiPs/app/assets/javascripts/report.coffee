# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  if $('.pagination').length && $('#cards').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 20
        $('.pagination').text("Loading more...")
        $.getScript(url)
    $(window).scroll()
