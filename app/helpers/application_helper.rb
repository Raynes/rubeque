module ApplicationHelper

  def errors_for(object)
    render "/shared/form_errors", object: object if object.errors.any?
  end
  alias :form_errors :errors_for

  def highlight_code(code)
    CodeRay.scan(code, :ruby).div(:css => :class)
  end

  def offset(per_page = Kaminari.config.default_per_page)
    ((params[:page] || 1).to_i - 1) * per_page
  end

  def google_analytics_js
    "<script type='text/javascript'>

      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', '#{ENV['google_analytics_id']}']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();

    </script>".html_safe
  end

  def gravatar_url(email, options = {})
    options = {r: "pg", d: "mm", s: 24}.merge(options) # pg rating
    id = Digest::MD5.hexdigest(email)
    "http://gravatar.com/avatar/#{id}.png?#{options.to_query}"
  end

  def gravatar_image(email, size = 24, css = {})
    email ||= ""
    options = {s: size}
    css = {class: "gravatar"}.merge(css)
    image_tag gravatar_url(email, options), css
  end
  
  def user_score(user)
    output = ''
    output << content_tag(:h1, 'Your score')
    output << bold_paragraph(link_to "Rank: #{user.rank.nil? ? 'undefined' : user.rank}", users_path(:page => user.scores_page))
    output << bold_paragraph(link_to "Score: #{user.score}", users_path(:page => user.scores_page))
    output << bold_paragraph(link_to "Problems solved: #{user.solution_count} / #{Problem.approved.count}", problems_path)
    output.html_safe
  end
  
  def bold_paragraph(text)
    content_tag :p do
      content_tag :b do
        text
      end
    end
  end
  
end
