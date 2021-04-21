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
   self.my_each do |x|
     if yield x
      array.push(x)
    end
    array
   end
  end
end
# rubocop:enable Style/For
# friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']
# invited_list = []

# friends.each do |friend|
#   if friend != 'Brian'
#     invited_list.push(friend)
#   end
# end
friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

friends.my_select { |friend| friend != 'Brian' }
