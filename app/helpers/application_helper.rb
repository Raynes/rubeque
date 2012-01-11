module ApplicationHelper

  def errors_for(object)
    render "/shared/form_errors", object: object if object.errors.any?
  end
  alias :form_errors :errors_for

end
