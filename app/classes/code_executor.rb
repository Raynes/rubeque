require 'timeout'

class CodeExecutor
  MAX_EXECUTION_TIME = 10 # seconds

  attr_accessor :code, :errors

  def initialize(code)
    @code = code
    @errors = []
  end

  def execute
    begin
      FakeFS.activate!
      evaluator = Proc.new do
        $SAFE = 3
        eval(@code)
      end
      success = Timeout::timeout(MAX_EXECUTION_TIME) { evaluator.call }

      if success == false
        @errors << "Your solution failed."
      end
    rescue Exception => e
      @errors << "Your solution failed: #{e.message}"
      return false
    ensure
      FakeFS.deactivate!
    end

    return success
  end

  def assert_equal(x, y)
    if x != y
      raise "The value '#{x}' does not equal '#{y}'."
    else
      return true
    end
  end
end
