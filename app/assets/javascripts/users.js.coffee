$ ->
  $("th.follow a:contains('Follow')").live "click", (event) ->
    event.preventDefault()
    user_id = $(this).closest("tr").attr("id")
    $.post "/following", { "following[user_id]": user_id}, (data) ->
      $("th.follow a:contains('Follow')").hide()
      $("th.follow a:contains('Unfollow')").show()
    return false

  $("th.follow a:contains('Unfollow')").live "click", (event) ->
    event.preventDefault()
    user_id = $(this).closest("tr").attr("id")
    $.ajax url: "/following/#{user_id}", type: "delete", complete: (x, d) ->
      if(x.status == 200)
        $("th.follow a:contains('Unfollow')").hide()
        $("th.follow a:contains('Follow')").show()
    return false

