class CodeGist

  attr_accessor :text, :extension, :link, :error

  def initialize(text, filename = "rubeque.rb", extension = ".rb")
    @text = text
    @extension = extension
    @filename = filename
  end

  def post
    file = {extension: @extension, input: @text, filename: @filename}
    result = Gist.write([file])
    if result =~ /^https:\/\/gist.github.com\//
      @link = result
      return true
    else
      raise "Error posting gist: #{e.message}"
    end
  end

  def self.create(text, file_type = "rb")
    gist = self.new(text, file_type)
    if gist.post
      return gist.link
    else
      return false
    end
  end
end
