editor = null

$ ->
  $("table#problems tr.problem").live "click", ->
    window.location = "/problems/#{$(this).attr('id')}"

  if($("#solution_code").length > 0)
    $("#solution_code").hide()
    editor = ace.edit 'editor'
    editor.setShowPrintMargin false
    editor.setTheme "ace/theme/twilight"
    RubyMode = require("ace/mode/ruby").Mode
    editor.getSession().setMode(new RubyMode())
    editor.getSession().setValue($("#solution_code").text())

    $("form#new_solution, form.edit_solution").submit (e) ->
      $("#solution_code").text editor.getSession().getValue()
