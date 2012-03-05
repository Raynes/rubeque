xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Rubeque Problems"
    xml.description "New problems on Rubeque.com"
    xml.link problems_url()

    for problem in @problems
      xml.item do
        xml.title problem.title
        xml.description problem.instructions
        xml.pubDate problem.created_at.to_s(:rfc822)
        xml.link problem_url(problem)
        xml.guid problem_url(problem)
      end
    end
  end
end
