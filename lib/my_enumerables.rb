module Enumerable
  # Your code goes here
  def my_select
    selected = []
    self.my_each do |element|
      selected << element if yield(element)
    end
    selected
  end

  def my_all?
    self.my_each do |element|
      return false unless yield(element)
    end
    true
  end

  def my_any?
    self.my_each do |element|
      return true if yield(element)
    end
    false
  end

  def my_none?
    self.my_each do |element|
      return false if yield(element)
    end
    true
  end

  def my_count
    return self.length unless block_given?

    count = 0
    self.each do |element|
      count = count + 1 if yield(element)
    end
    count
  end

  def my_map
    mapped_arr = []
    self.each do |element|
      mapped_arr << yield(element)
    end
    mapped_arr
  end

  def my_inject(initial_operand = nil, symbol = nil)
    if initial_operand.is_a?(Symbol)
      symbol = initial_operand
    end

    result = initial_operand.nil? ? self[0] : initial_operand
    
    if symbol.is_a?(Symbol)
      self.each do |element|
        result.&symbol(element)
      end
    end

    self.each do |element|
      result = yield(result, element)
    end

    result
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    self.each {|element| yield(element)}
  end

  def my_each_with_index
    self.each_with_index {|element, index| yield(element, index)}
  end
end
