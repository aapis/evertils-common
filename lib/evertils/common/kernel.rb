class String
  def capitalize_first_char
    self.sub(/^(.)/) { $1.capitalize }
  end
end

# required for some reason, thrift is weird
class Hash
  def encoding
  end

  def encode(arg)
  end

  def force_encoding(arg)
  end
end

class NilClass
  def bytesize
    0
  end
end