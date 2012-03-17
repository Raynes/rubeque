module SolutionsHelper

  def twitter_link(problem, paste)
    url = "http://rubeque.com/problems/#{problem.id}"
    text = URI.escape("Check out my solution to '#{problem.title}' (#{url}) on #rubeque: #{paste}")
    link = "http://twitter.com/share?"
    link += "text=#{text}"
    link_to "Edit your tweet on Twitter", link, class: "twitter"
  end
end
