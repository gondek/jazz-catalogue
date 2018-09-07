/* global $ */
function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min
}

$(document).ready(function () {
  $('img.lazy-load').removeClass('hide').unveil(200, function () {
    $(this).on('load', function () {
      var that = $(this)
      setInterval(function () {
        that.removeClass('lazy-load')
      }, getRandomInt(0, 4) * 50 + 200)
    })
  })
})
