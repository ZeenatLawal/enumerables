# rubocop:disable Style/For
module Enumerable
  def my_each
    for index in self
      yield index
    end
  end

  def my_each_with_index
    b = 0
    for a in self
      yield a, b
      b += 1
    end
  end

  def my_select
    array = []
    my_each do |i|
      array.push(i) if yield i
    end
    array
  end

  def my_all?
    return true if empty?

    my_each { |i| return false if yield i }
  end

  def my_any?
    if empty?
      true
    elsif include?(nil) || include?(false)
      false
    else my_select { |i| return true if yield i }
    end
  end
end
# rubocop:enable Style/For
