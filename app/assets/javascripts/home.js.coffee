# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
     if $('.pagination').length
          $(window).scroll ->
                  url = $('.pagination a[rel=next]').attr('href')
                  if url &&  $(window).scrollTop() > ($(document).height()/2 )- $(window).height()-50
                          $('.pagination').text('Fetching more products...')
                          $.ajax({
                            url: url,
                            dataType: "script",
                          });
     $(window).scroll()
     