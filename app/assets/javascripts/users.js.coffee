$ ->
  $("th.follow a:contains('Follow')").live "click", (event) ->
    event.preventDefault()
    $(this).hide()
    user_id = $(this).closest("tr").attr("id")
    $.post "/following", { "following[user_id]": user_id}, (data) ->
      $("tr##{data.user_id} th.follow a:contains('Unfollow')").delay(300).fadeIn(200)
    return false

  $("th.follow a:contains('Unfollow')").live "click", (event) ->
    event.preventDefault()
    $(this).hide()
    user_id = $(this).closest("tr").attr("id")
    $.ajax url: "/following/#{user_id}", type: "delete", success: (data) ->
      $("tr##{data.user_id} th.follow a:contains('Follow')").delay(300).fadeIn(200)
    return false

