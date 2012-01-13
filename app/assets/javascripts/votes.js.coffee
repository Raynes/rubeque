$ ->
  $("a.upvote, a.downvote").live "click", (event) ->
    event.preventDefault()
    solution = $(this).data 'solution-id'
    debugger
    upvote = $(this).hasClass 'upvote'
    $.post "/votes", { "vote[solution_id]": solution, "vote[up]": upvote }, (data) ->
      id = $(data).attr('id')
      $("##{id}").replaceWith(data)
    return false
