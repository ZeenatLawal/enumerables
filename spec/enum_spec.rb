require './enumerables'

describe Enumerable do
  array = %w[Sharon Leo Leila Brian Arun]
  describe '#my_each' do
    context 'if block not given' do
      it 'returns enum' do
        expect(array.my_each).to be_an Enumerator
      end
    end

    context 'if block given' do
      it 'yields item' do
        arr = array.my_each { |friend| friend }
        expect(arr).to eq(%w[Sharon Leo Leila Brian Arun])
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
        expect(arr).to eq(['1: Leo', '3: Brian'])
      end
    end
  end

  describe '#my_select' do
    context 'if block not given' do
      it 'returns enum' do
        expect(array.my_select).to be_an Enumerator
      end
    end

    context 'if block given' do
      it 'yields selected items' do
        arr = array.my_select { |friend| friend != 'Brian' }
        expect(arr).to eq(%w[Sharon Leo Leila Arun])
      end
    end
  end

  describe "#my_all?" do
    context 'if block given' do
      it "returns false if all the items doesn't yield true" do
        expect(%w[Sharon Leo Leila Brian Arun].my_all? { |word| word.length > 5 }).to be(false)
      end
    end
    context 'if block not given' do
      it "returns false if all the items doesn't satisfy a given condition" do
        expect(%w[Sharon Leo Leila Brian Arun].my_all?(/a/)).to be(false)
      end
    end
  end
end
