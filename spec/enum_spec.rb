require 'rspec'
require './enumerables'

RSpec.describe Enumerable do
  array = %w[Sharon Leo Leila Brian Arun]
  describe '#my_each' do
    context 'if block not given' do
      it 'returns enum' do
        expect(array.my_each).to be_an Enumerator
      end
    end

    context 'if block given' do
      it 'yields index' do
        arr = []
        array.my_each { |index| arr.push(index) }
        expect(arr).to eq(%w[Sharon Leo Leila Brian Arun])
      end
    end
  end
end
