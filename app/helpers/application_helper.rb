module ApplicationHelper

  def errors_for(object)
    render "/shared/form_errors", object: object if object.errors.any?
  end
  alias :form_errors :errors_for

  def highlight_code(code)
    CodeRay.scan(code, :ruby).div(:css => :class)
  end

  def offset(per_page = 50)
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
end
