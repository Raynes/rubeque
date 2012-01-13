module VotesHelper

  def vote_link(solution, up = true)
    if vote = Vote.where(user_id: current_user.id, solution_id: solution.id, up: up).first
      arrow_image = "red_arrow.png"
      css = "selected "
    else
      arrow_image = "arrow.png"
      css = ""
    end
    css += "#{up ? "up" : "down"}vote"
    link_to image_tag(arrow_image), "#", class: css, "data-solution-id" => solution.id
  end

end
