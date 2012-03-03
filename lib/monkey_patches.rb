class String
  def simple_sub(pattern, replace)
    res = self + " "
    res.split(pattern).join(replace)[0..-2]
  end
end
