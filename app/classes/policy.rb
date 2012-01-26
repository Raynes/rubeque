class Policy < Rubycop::Analyzer::Policy
  def initialize
     @const_list = Rubycop::Analyzer::GrayList.new
     @call_list  = Rubycop::Analyzer::GrayList.new
     initialize_const_blacklist
     initialize_call_blacklist
   end

  def initialize_call_blacklist
    blacklist_calls CALL_BLACKLIST
  end

  def blacklist_calls(calls)
    calls.each{|c| blacklist_call(c) }
  end

  def blacklist_call(call)
    @call_list.blacklist(call.to_s)
  end

  def visit_Call(node)
    @call_list.allow?(node.identifier.token.to_s) && [node.target, node.arguments, node.block].compact.all? { |e| visit(e) }
  end

end
