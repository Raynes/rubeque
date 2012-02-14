editors = new Array()

$ ->
  $("table#problems tr.problem").live "click", ->
    window.location = "/problems/#{$(this).attr('id')}"

  if($(".code-editor").length > 0)
    $(".code-editor").each (index, elm) ->
      $(elm).prev("textarea").hide()
      editor = ace.edit elm.id
      editor.setShowPrintMargin false
      editor.setTheme "ace/theme/twilight"
      RubyMode = require("ace/mode/ruby").Mode
      editor.getSession().setMode(new RubyMode())
      editor.getSession().setValue($(elm).prev("textarea").text())
      editor.getSession().setTabSize(2)
      editor.getSession().setUseSoftTabs(true)
      $(elm).css("font-size", "13px")
      editors.push(editor)

    $("form#new_solution, form.edit_solution").submit (e) ->
      $.each editors, (index, editor) ->
        $(editor.container).prev("textarea").val editor.getSession().getValue()

    $("form#new_problem, form.edit_problem").submit (e) ->
      $.each editors, (index, editor) ->
        $(editor.container).prev("textarea").val editor.getSession().getValue()
