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
    begin
      result = SafeEval.eval(code)
      if result == "true\n"
        return true
      else
        @errors = result
      end
    rescue Exception => e
      @errors = "Your solution failed: #{e.message}"
    end
  end

end
