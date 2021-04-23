# rubocop:disable Style/For, Style/GuardClause
# rubocop:disable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

module Enumerable
  def my_each
    return enum_for unless block_given?

    for index in self
      yield index
    end
  end

  def my_each_with_index
    return enum_for unless block_given?

    b = 0
    for a in self
      yield a, b
      b += 1
    end
  end

  def my_select
    return enum_for unless block_given?

    array = []
    my_each do |i|
      array.push(i) if yield i
    end
    array
  end

  def my_all?(args = nil)
    if block_given?
      my_each { |i| return false if yield i == false }
    elsif args.nil?
      my_each { |i| return false if i == false || i.nil? }
    elsif args.instance_of?(Class)
      my_each { |i| return false if i.class.superclass != args && i.class != args }
    elsif args.instance_of?(Regexp)
      my_each { |i| return false unless args.match(i) }
    else
      my_each { |i| return false if i != args }
    end
    true
  end

  def my_any?
    if empty?
      true
    elsif include?(nil) || include?(false)
      false
    else my_select { |i| return true if yield i }
    end
  end

  def my_none?
    if empty?
      true
    elsif block_given?
      my_each do |i|
        if yield i
          return false
        else
          return true
        end
      end
    else
      my_each do |i|
        if i
          return false
        else
          return true
        end
      end
    end
  end

  def my_count(*args)
    i = 0
    if block_given?
      my_each do |x|
        i += 1 if yield x
      end
    elsif args.empty?
      my_each do |_x|
        i += 1
      end
    else
      my_each do |x|
        i += 1 if x == args[0]
      end
    end
    i
  end

  def my_map(arg = nil)
    return enum_for unless block_given?

    array = []
    if arg.nil? && block_given?
      my_each { |index| array.push(yield index) }
    else
      result = arg
      my_each { |index| array.push(result.call(index)) }
    end
    array
  end

  def my_inject(num = 0, sym = nil)
    if num.instance_of?(Integer) || num.instance_of?(String)
      result = num
      my_each { |item| result = yield(result, item) }
    elsif sym.instance_of?(Symbol)
      result = num
      my_each { |item| result = result.send(sym, item) }
    end
    result
  end
end

# rubocop:enable Style/For, Style/GuardClause
# rubocop:enable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

def multiply_els(array)
  array.my_inject(1) { |index, result| result * index }
end
