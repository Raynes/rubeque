require 'timeout'

class CodeExecutor
  MAX_EXECUTION_TIME = 15 # seconds

  attr_accessor :code, :errors

  def initialize(code, options = {})
    @code = code
    @excluded_methods = options[:excluded_methods]
    @errors = []
  end

  def execute
    begin
      check_code(@code)

      FakeFS.activate!

      code = PRECODE + @code
      evaluator = Proc.new { eval(code) }
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

  def check_code(code)
    policy = initialize_policy
    ast = Rubycop::Analyzer::NodeBuilder.build(code)
    if !ast.accept(policy)
      raise "your code contains a class or method call that is not allowed."
    end
    return true
  end

  def initialize_policy
    policy = Policy.new
    policy.blacklist_calls( @excluded_methods )

    constants = ["Mongoid", "Document"] + model_names
    constants.each {|c| policy.blacklist_const(c)}
    return policy
  end

  def model_names
    Dir.chdir(File.join("#{Rails.root}", "app", "models"))
    filenames = Dir.glob("*.rb")
    filenames.map{|f| f.match(/^[^.]*/).to_s.camelize}
  end

  PRECODE = <<-code
    def assert_equal(x, y)
      if x != y
        raise "The value '\#{x}' does not equal '\#{y}'."
      else
        return true
      end
    end

    Object.instance_eval { remove_const :CodeExecutor }
    $SAFE = 3
  code

end
