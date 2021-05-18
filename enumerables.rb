#!/usr/bin/env ruby

# rubocop:disable Style/For
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

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
    to_a
    if block_given?
      my_each { |i| return false unless yield(i) == true }
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

  def my_any?(args = nil)
    to_a
    if block_given?
      my_each { |i| return true if yield i }
    elsif args.nil?
      my_each { |i| return true if i }
    elsif args.instance_of?(Class)
      my_each { |i| return true if i.instance_of?(args) || i.class.superclass == args }
    elsif args.instance_of?(Regexp)
      my_each { |i| return true if args.match(i) }
    else
      my_each { |i| return true if i == args }
    end
    false
  end

  def my_none?(args = nil)
    if block_given?
      my_each { |i| return false if yield i }
    elsif args.instance_of?(Regexp)
      my_each { |i| return false if args.match(i) }
    elsif args.instance_of?(Class)
      my_each { |i| return false if i.is_a?(args) }
    elsif args.nil?
      my_each { |i| return false if i }
    else
      my_each { |i| return false if i == args }
    end
    true
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

  def my_inject(num = nil, sym = nil)
    if sym.instance_of?(Symbol) || sym.instance_of?(String)
      result = num
      my_each do |item|
        result = result.nil? ? item : result.send(sym, item)
      end
      result
    elsif num.instance_of?(Symbol) || num.instance_of?(String)
      result = nil
      my_each do |item|
        result = result.nil? ? item : result.send(num, item)
      end
      result
    else
      result = num
      my_each do |item|
        result = result.nil? ? item : yield(result, item)
      end
    end
    result
  end
end

# rubocop:enable Style/For
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

def multiply_els(array)
  array.my_inject(1) { |index, result| result * index }
end
