require 'test/unit'
require 'timeout'

class CodeExecutor
  MAX_EXECUTION_TIME = 10 # seconds

  attr_accessor :code, :errors

  def initialize(code)
    @code = code
    @errors = []
  end

  def execute
    # initialize test unit
    extend Test::Unit::Assertions

    begin
      FakeFS.activate!
      evaluator = Proc.new do
        $SAFE = 3
        eval(@code)
      end
      timeout = Timeout::timeout(MAX_EXECUTION_TIME) { success = evaluator.call }

      if timeout
        @errors << "Your solution timed out."
      elsif success == false
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
end
