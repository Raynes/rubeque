require 'timeout'
require 'open3'

module SafeEval
  def self.setup(timelimit=15, memlimit=10)
    @@timelimit = timelimit
    @@memlimit = memlimit
    @@memlimit = 50 # FIXME
    
    @@code_start =
      "require #{__FILE__.inspect};" +
      "SafeEval.setup(#{@@timelimit.inspect}, #{@@memlimit.inspect});" +
      "puts SafeEval._safe_eval "
  end
  
  def self.eval(code)
    begin
      Timeout.timeout(5) do
        Open3.capture2e('ruby', :stdin_data => @@code_start + code.inspect).first
      end
    rescue Timeout::Error
      '<timeout hit>'
    rescue NameError
      SafeEval.setup
      retry
    end
  end
  
  # You probablyyyyyy don't want to run this directly.
  # It won't have as good of a time limit (it'll limit it to @@timelimit CPU time,
  # not total runtime)
  def self._safe_eval(code)
    # RAM limit
    Process.setrlimit(Process::RLIMIT_AS, @@memlimit*1024*1024)
    
    # CPU time limit. 5s means 5s of CPU time.
    Process.setrlimit(Process::RLIMIT_CPU, @@timelimit)
    
    # Things we want, or need to have, available in eval
    require 'stringio'
    require 'pp'
    
    # fakefs goes last, because I don't think `require` will work after it
    require 'fakefs'
    
    # Undefine FakeFS
    [:FakeFS, :RealFile, :RealFileTest, :RealFileUtils, :RealDir].each do |x|
      Object.instance_eval{ remove_const x }
    end
    
    output_io, result, error = nil
    
    begin
      output_io = $stdout = $stderr = StringIO.new
      code = '$SAFE = 3; BEGIN { $SAFE=3 };' + code
      
      result = ::Kernel.eval(code, TOPLEVEL_BINDING)
    rescue Exception => e
      error = "#{e.class}: #{e.message}"
    ensure
      $stdout = STDOUT
      $stderr = STDERR
    end
    
    output = output_io.string
    
    if output.empty?
      if error
        error
      else
        result.inspect
      end
    else
      output
    end
  end
end
