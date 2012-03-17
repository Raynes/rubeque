$ ->
  $("a.upvote, a.downvote").live "click", (event) ->
    event.preventDefault()
    solution = $(this).data 'solution-id'
    upvote = $(this).hasClass 'upvote'
    $("div.votes-#{solution}").hide()
    $.post "/votes", { "vote[solution_id]": solution, "vote[up]": upvote }, (data) ->
      id = $(data).attr('id')
      $("div.votes-#{id}").html($(data).html())
      $("div.votes-#{id}").delay(300).fadeIn(400)
    return false

  $("a.report-solution").live "click", (event) ->
    event.preventDefault()
    self = $(event.target)
    link = self.attr("href")
    self.text("Reported")
    $.ajax url: link, complete: (xhr, text) ->
      self.delay(300).fadeOut(500)

  $("#solution-share-link").click ->
    $("#solution-share-link").select()
