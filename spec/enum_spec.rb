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
      it 'yields item' do
        array.my_each { |friend| puts friend }
        expect(array).to eq(%w[Sharon Leo Leila Brian Arun])
      end
    end
  end

  describe '#my_each_with_index' do
    context 'if block not given' do
      it 'returns enum' do
        expect(array.my_each_with_index).to be_an Enumerator
      end
    end

    context 'if block given' do
      it 'yields item with index' do
        arr = []
        array.my_each_with_index { |friend, index| arr.push("#{index}: #{friend}") if index.odd? }
        expect(arr).to eq(["1: Leo", "3: Brian"])
      end
    end
  end
end
