class Array
  def my_each
    return to_enum(:my_each) unless block_given?

    for element in self do
      yield(element)
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    for element in self do
      yield(element, index)
      index += 1
    end
  end
end

module Enumerable
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
    self.my_each do |element|
      count = count + 1 if yield(element)
    end
    count
  end

  def my_map
    mapped_arr = []
    self.my_each do |element|
      mapped_arr << yield(element)
    end
    mapped_arr
  end

  def my_inject(*args)
    case args
    in [a, b]
      initial_operand = a
      symbol = b
    in [a] if a.is_a?(Symbol)
      symbol = a
    in [a] unless a.is_a?(Symbol)
      initial_operand = a
    else
      initial_operand = nil
      symbol = nil
    end

    result = initial_operand.nil? ? self[0] : initial_operand
    
    if symbol.is_a?(Symbol)
      self.my_each_with_index do |element, index|
        next if initial_operand.nil? && index.zero?

        result.&symbol(element)
      end
    end

    self.my_each_with_index do |element, index|
      next if initial_operand.nil? && index.zero?

      result = yield(result, element)
    end

    result
  end
end
