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
        array.my_each { |index| puts index }
        expect(array).to eq(%w[Sharon Leo Leila Brian Arun])
      end
    end
  end
end
