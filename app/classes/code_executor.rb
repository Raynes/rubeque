require 'sicuro'

class CodeExecutor
  MAX_EXECUTION_TIME = 15 # seconds

  ERROR_PATTERNS = [
    /^SystemExit:/,
    /Error\S*:/
  ]

  attr_accessor :code, :errors

  def initialize(code, options = {})
    @code = code
    @excluded_methods = options[:excluded_methods]
    @errors = []
  end

  def execute
    code = PRECODE + @code
    timelimit = MAX_EXECUTION_TIME
    memlimit  = 30

    Sicuro.setup(timelimit, memlimit)
    begin
      result = Sicuro.eval(code)
    rescue Exception => e
      @errors << e.message
    end
    puts result

    ERROR_PATTERNS.each {|re| @errors << result if result =~ re}
    if result == "<timeout hit>"
      @errors << "Your solution timed out."
    end

    return @errors.empty?
  end

  PRECODE = <<-code
    def assert_equal(x, y)
      if x != y
        raise "The value '\#{x}' does not equal '\#{y}'."
      else
        return true
      end
    end
  code

end
