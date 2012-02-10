require 'spec_helper'
require 'timeout'

describe CodeExecutor do
  before(:each) do

  end

  describe "#execute" do

    #it "should return false if the input is Kernel.exit!" do
      #code_executor = CodeExecutor.new("Kernel.exit!")
      #puts code_executor.execute
      #code_executor.execute.should eql(false)
      #code_executor.errors.count.should >= 1
      #code_executor.errors.first.downcase.should =~ /your code contains a class or method call that is not allowed/
    #end

    #it "should halt after #{CodeExecutor::MAX_EXECUTION_TIME} seconds" do
      #code_executor = CodeExecutor.new("loop {}")
      #result = Timeout::timeout(CodeExecutor::MAX_EXECUTION_TIME+1) { code_executor.execute }
      #result.should eql(false)
      #code_executor.errors.count.should >= 1
      #code_executor.errors.first.downcase.should == "<timeout hit>"
    #end

    it "should return false if given an untrue assertion" do
      code_executor = CodeExecutor.new("assert_equal 1, 0")
      code_executor.execute.should eql(false)
      code_executor.errors.first.downcase.should =~ /does not equal/
    end

  end

end
