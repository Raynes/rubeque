$ ->
  $("table#problems tr.problem").live "click", ->
    window.location = "/problems/#{$(this).attr('id')}"
