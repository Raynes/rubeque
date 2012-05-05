class CodeRefheap

  attr_accessor :link, :error

  def initialize(text)
    @text = text
    @heap = Refheap::Paste.new
  end

  def post
    result = @heap.create(@text, :language => "Ruby")['url']
    if result =~ /^https:\/\/www.refheap.com\//
      @link = result
      return true
    else
      raise "Error pasting to RefHeap"
    end
  end

  def self.create(text)
    heap = self.new(text)
    if heap.post
      return heap.link
    else
      return false
    end
  end
end
