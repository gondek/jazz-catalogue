/* global $ */
$(document).ready(function () {
  $('img.lazy-load').removeClass('hide').unveil(200, function () {
    $(this).on('load', function () {
      $(this).removeClass('lazy-load')
      $(this).siblings('.lazy-load').removeClass('lazy-load')
    })
  })
})
