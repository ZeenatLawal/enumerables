# rubocop:disable Style/For, Style/GuardClause
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
    if empty?
      true
    elsif block_given?
      my_each do |i|
        if yield i
          return true
        else
          return false
        end
      end
    else
      my_each do |i|
        if i
          return true
        else
          return false
        end
      end
    end
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
    if !block_given?
        if args.empty?
          self.my_each do |x| i += 1
          end
        else
          self.my_each do |x|
          if x == args[0]
          i += 1
         end
        end
        end
    else
        self.my_each do |x|
        if yield x
          i += 1
        end
      end
      end
      i
    end
end
# rubocop:enable Style/For, Style/GuardClause

letters =["a", "a", "a", "b", "c", "d", "a"]
puts letters.my_count("a")

numbers = [1,2,3,4,5,6]
puts numbers.my_count(&:odd?)