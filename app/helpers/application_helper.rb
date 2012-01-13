module ApplicationHelper

  def errors_for(object)
    render "/shared/form_errors", object: object if object.errors.any?
  end
  alias :form_errors :errors_for
  
  
  def highlight_code(code)
    CodeRay.scan(code, :ruby).div(:css => :class)
  end

end
