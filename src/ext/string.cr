# Assert string not empty
class String
  def not_empty!(message = "Empty assertion failed")
    raise message if self.empty?
  end
end
