class CodeExecutor

  attr_accessor :code, :errors

  def initialize(code)
    @code = code
    @errors = []
  end

  def execute
    # initialize test unit
    require 'test/unit'
    extend Test::Unit::Assertions

    begin
      FakeFS.activate!
      evaluator = Proc.new do
        $SAFE = 3
        eval(@code)
      end
      success = evaluator.call
      @errors << "Your solution failed." unless success
    rescue Exception => e
      @errors << "Your solution failed: #{e.message}"
      return false
    ensure
      FakeFS.deactivate!
    end

    return success
  end
end
