require 'rspec'
require './enumerables'

RSpec.describe Enumerable do
  array = [1, 2, 3]
  describe '#my_each' do
    context 'if block not given' do
      it 'returns enum' do
        expect(array.my_each).to be_an Enumerator
      end
    end

    context 'if block given' do
      it 'yields index' do
        arr = []
        array.my_each { |index| arr.push(index**3) }
        expect(arr).to eq([1, 8, 27])
      end
    end
  end
end
