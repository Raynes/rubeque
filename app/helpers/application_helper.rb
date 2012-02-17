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

end
