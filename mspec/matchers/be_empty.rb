class BeEmptyMatcher
  def matches?(actual)
    @actual = actual
    @actual.empty?
  end
  
  def failure_message
    ["Expected #{@actual}", "to be empty"]
  end

  def negative_failure_message
    ["Expected #{@actual}", "not to be empty"]
  end
end

class Object
  def be_empty
    BeEmptyMatcher.new
  end
end
