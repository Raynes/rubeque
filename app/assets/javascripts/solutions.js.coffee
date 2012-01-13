$ ->
  $("a.upvote, a.downvote").live "click", (event) ->
    event.preventDefault()
    solution = $(this).data 'solution-id'
    upvote = $(this).hasClass 'upvote'
    $(this).closest("div.votes").hide()
    $.post "/votes", { "vote[solution_id]": solution, "vote[up]": upvote }, (data) ->
      id = $(data).attr('id')
      $("##{id}").replaceWith($(data).css("display", "none"))
      $("##{id}").delay(300).fadeIn(400)
    return false
