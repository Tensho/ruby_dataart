require_relative 'spec_helper'
require_relative 'storage'

describe 'Storage (implements trie data structure)' do
  subject { Storage.new }

  describe '#add' do
    context 'empty string' do
      before { subject.add('') }

      it 'returns storage with empty trie' do
        expected = { "" => {} }
        subject.to_h.must_equal expected
      end
    end

    context 'nonempty string' do
      before { subject.add('abc,abd,abde,abdf') }

      it 'returns storage with built trie and marked terminals' do
        expected = {
          "" => { "a" => { "b" => { "c(X)" => {},
                                    "d(X)" => { "e(X)" => {},
                                                "f(X)" => {}
                                              }
                                  }
                         }
                }
        }
        subject.to_h.must_equal expected
      end
    end
  end

  describe '#contains?' do
    context 'empty word' do
      it 'returns true' do
        subject.contains?('').must_equal true
      end
    end

    context 'empty storage' do
      context 'nonempty word' do
        it 'returns false' do
          subject.contains?('abc').must_equal false
        end
      end
    end

    context 'nonempty storage' do
      before { subject.add('abcd,abcde,abcdf') }

      context 'word present in storage' do
        it 'returns true' do
          subject.contains?('abcd').must_equal true
        end
      end

      context 'prefix present in storage, but not whole word' do
        it 'returns false' do
          subject.contains?('abc').must_equal false
        end
      end

      context 'word absent in storage' do
        it 'returns false' do
          subject.contains?('xyz').must_equal false
        end
      end
    end
  end

  describe '#find' do
    context 'empty storage' do
      it 'returns empty array' do
        subject.find('abc').must_be_empty
      end
    end

    context 'nonempty storage' do
      before { subject.add('abc,abcd,abcde,xyz') }

      context 'for storage with words started with prefix' do
        it 'returns words started with prefix' do
          subject.find('abc').must_equal ["abc", "abcde", "abcd"]
        end
      end

      context 'for storage without words started with prefix' do
        it 'returns empty array' do
          subject.find('uvw').must_be_empty
        end
      end
    end

    context 'prefix less than 3 symbols' do
      let(:prefix) { 'uv' }

      it 'raises argument error exception' do
        -> { subject.find(prefix) }.must_raise ArgumentError
      end
    end
  end
end
