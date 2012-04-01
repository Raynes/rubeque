require 'sicuro'

class CodeExecutor
  MAX_EXECUTION_TIME = ENV['PROBLEM_MAX_TIME'] || 5 # seconds

  ERROR_PATTERNS = [
    /^SystemExit:/,
    /Error\S*:/,
    /Exception\S*:/,
    /^fatal/,
    /Interrupt\S*:/,
    /Errno::/
  ]

  attr_accessor :code, :errors, :time, :uid, :result

  def initialize(code, options = {})
    @code = code
    @excluded_methods = options[:excluded_methods]
    @errors = []
    @uid = generate_uid
  end

  def execute
    timelimit = MAX_EXECUTION_TIME.to_i
    memlimit  = 30

    Sicuro.setup(timelimit, memlimit)
    begin
      start_time = Time.now
      @result = Sicuro.eval(combined_code)
      self.time = (Time.now - start_time)
    rescue Exception => e
      @errors << e.message
    end

    ERROR_PATTERNS.each {|re| @errors << result if result =~ re}
    if result == "<timeout hit>"
      @errors << "Your solution timed out."
    elsif result != @uid && @errors.empty?
      @errors << "Solution contained unexpected output or returned prematurely#{Rails.env.prodution? ? '.' : ": #{result}"}"
    end

    return @errors.empty?
  end

  def generate_uid
    UUID.new.generate
  end

  def post_code
    %{\nputs "#{@uid}"}
  end

  def pre_code
    PRECODE
  end

  def post_code
    %{\nputs "#{@uid}"}
  end

  def combined_code
    [pre_code, @code, post_code].join("\n")
  end

  def result
    @result.to_s.strip
  end

  PRECODE = <<-code
    def assert_equal(x, y, message = nil)
      if x != y
        raise message ? message : "The value '\#{x}' does not equal '\#{y}'."
      else
        return true
      end
    end
  code

end
