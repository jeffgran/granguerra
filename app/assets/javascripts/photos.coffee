# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#galleries").nanoGallery
    kind: 'flickr'
    userID: '33995200@N00'
    albumList: '72157629558115122|72157624405194867'  
