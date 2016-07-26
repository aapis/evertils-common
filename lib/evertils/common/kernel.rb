class String
  def capitalize_first_char
    self.sub(/^(.)/) { $1.capitalize }
  end
end