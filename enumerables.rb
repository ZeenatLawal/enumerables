# rubocop:disable Style/For
module Enumerable
  def my_each
    for index in self
      yield index
    end
  end
end
# rubocop:enable Style/For
