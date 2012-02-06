editor = null

$ ->
  $("table#problems tr.problem").live "click", ->
    window.location = "/problems/#{$(this).attr('id')}"

  if($("#solution_code, #problem_code").length > 0)
    $("#solution_code, #problem_code").hide()
    editor = ace.edit 'editor'
    editor.setShowPrintMargin false
    editor.setTheme "ace/theme/twilight"
    RubyMode = require("ace/mode/ruby").Mode
    editor.getSession().setMode(new RubyMode())
    editor.getSession().setValue($("#solution_code, #problem_code").text())
    $("#editor").css("font-size", "13px")

    $("form#new_solution, form.edit_solution").submit (e) ->
      $("#solution_code").text editor.getSession().getValue()

    $("form#new_problem, form.edit_problem").submit (e) ->
      $("#problem_code").text editor.getSession().getValue()
