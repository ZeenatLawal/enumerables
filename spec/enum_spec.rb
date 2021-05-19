require './enumerables'

describe Enumerable do
  array = %w[Sharon Leo Leila Brian Arun]
  num_array = [10, 20, 30, 5, 7, 9, 3]
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

  describe '#my_all?' do
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

  describe '#my_any?' do
    context 'if block given' do
      it 'returns true if any of the item yields true' do
        expect(%w[Sharon Leo Leila Brian Arun].my_any? { |word| word.length > 5 }).to be(true)
      end
    end
    context 'if block not given' do
      it 'returns false if any of the item satisfies a given condition' do
        expect(%w[Sharon Leo Leila Brian Arun].my_any?(/a/)).to be(true)
      end
    end
  end

  describe '#my_none?' do
    context 'if block given' do
      it 'returns true if none of the items yield true' do
        expect(%w[Sharon Leo Leila Brian Arun].my_none? { |word| word.length > 6 }).to be(true)
      end
    end
    context 'if block not given' do
      it 'returns true if none of the items satisfy a given condition' do
        expect(%w[Sharon Leo Leila Brian Arun].my_none?(/c/)).to be(true)
      end
    end
  end

  describe '#my_count' do
    context 'if block given' do
      it 'returns number of items satisfying the condition' do
        expect(%w[Sharon Leo Leila Brian Arun].my_count { |word| word.length > 5 }).to eq(1)
      end
    end
    context 'if block and argument given' do
      it 'returns number of arguments satisfying the condition' do
        expect(%w[Sharon Leo Leila Brian Arun Leon Leone].my_count('Leo') { |word| word == 'Leo' }).to eq(1)
      end
    end
    context 'if block not given, but argument given' do
      it 'returns count of that particular argument' do
        expect(%w[Sharon Leo Leila Leo Brian Arun Leo].my_count('Leo')).to eq(3)
      end
    end
    context 'if block and argument both not given' do
      it 'returns size of the instance' do
        expect(%w[Sharon Leo Leila Brian Arun].my_count).to eq(5)
      end
    end
  end

  describe '#my_map' do
    context 'if block not given' do
      it 'returns enum' do
        expect(array.my_map).to be_an Enumerator
      end
    end

    context 'if block given' do
      it 'returns a new array applying the given operation to the items' do
        arr = array.my_map(&:upcase)
        expect(arr).to eq(%w[SHARON LEO LEILA BRIAN ARUN])
      end
    end
  end

  describe '#my_inject' do
    context 'if block given' do
      it 'returns items that passes our filter' do
        num = []
        num_array.my_inject([]) { |_result, element| num << element.to_s if element > 9 }
        expect(num).to eq(%w[10 20 30])
      end
    end
    context 'if block not given, but argument given' do
      it 'returns sum of items' do
        num = num_array.my_inject(:+)
        expect(num).to eq(84)
      end
    end
  end
end
