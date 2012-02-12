module SolutionsHelper

  def twitter_link(problem, gist)
    text = URI.escape("Check out my solution to #{problem.title} on #rubeque #{gist}")
    link = "http://twitter.com/share?"
    link += "text=#{text}"
    link += "&url=#{URI.escape("http://www.rubeque.com/problems/#{problem.id}")}"
    link_to "Tweet your solution on Twitter", link 
  end
end
