# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#galleries").nanoGallery
    kind: 'flickr'
    userID: '33995200@N00'
    #albumList: '72157654055037724'
    photoset: '72157654055037724'
    #openOnStart: '72157654055037724'
    displayBreadcrumb: false
    thumbnailLabel: { hideIcons:true, display: false }
