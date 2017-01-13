# To be used for utility functions
$(document).ready ->
  $('ul.header-nav li').on 'click', ->
    $('li').removeClass 'active'
    $(this).addClass 'active'
    $('#sub_header').text($(this).find('a').text())
