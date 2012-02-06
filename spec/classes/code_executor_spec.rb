require 'spec_helper'
require 'timeout'

describe CodeExecutor do
  before(:each) do

  end

  describe "#execute" do

    it "should not allow me to execute Kernel.exit!" do
      code_executor = CodeExecutor.new("Kernel.exit!")
      code_executor.execute.should eql(false)
      code_executor.errors.count.should >= 1
      code_executor.errors.first.downcase.should =~ /your code contains a class or method call that is not allowed/
    end

    it "should halt after 10 seconds" do
      code_executor = CodeExecutor.new("(1..99999999999999999).each {|i| i*999999999999 }")
      result = Timeout::timeout(12) { code_executor.execute }
      result.should eql(false)
      code_executor.errors.count.should >= 1
      code_executor.errors.first.downcase.should =~ /execution expired/
    end

    it "should return false if given an untrue assertion" do
      code_executor = CodeExecutor.new("assert_equal 1, 0")
      code_executor.execute.should eql(false)
      code_executor.errors.first.downcase.should =~ /does not equal/
    end

  end

end
