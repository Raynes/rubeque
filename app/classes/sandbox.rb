class Sandbox

  PRECODE =<<-code
    def assert_equal(x, y)
      if x != y
        raise "The value '\#{x}' does not equal '\#{y}'."
      else
        return true
      end
    end
  code

  attr_accessor :code, :errors

  def initialize(code)
    @code = code
  end

  def execute
    code = PRECODE + @code
    result = SafeEval.eval(code)
    if result != "true\n"
      @errors = result
    end
  end

end
