/* global $ */
$(document).ready(function () {
  $('.lazy-load').removeClass('hide').unveil(200, function () {
    $(this).on('load', function () {
      $(this).removeClass('lazy-load')
    })
  })
})
