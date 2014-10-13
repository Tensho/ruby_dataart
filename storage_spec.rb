require_relative 'spec_helper'
require_relative 'storage'

describe 'Storage (implements trie data structure)' do
  subject { Storage.new }

  describe '#add' do
    context 'empty string' do
      let(:str) { '' }

      it 'root node has not children' do
        subject.add(str)
        subject.root_node.children.must_be_empty
      end
    end

    context 'nonempty string' do
      let(:str_1) { 'abc, def, xyz' }
      let(:str_2) { 'abc, def, ghi' }

      it 'root node has children' do
        subject.add(str_1)
        subject.add(str_2)
        subject.root_node.children.wont_be_empty
        # TODO: subject.traverse(root_node)
        subject.root_node.children.map(&:value).must_equal ['abc']
        subject.root_node.children.flat_map(&:children).flat_map(&:value).must_equal ['def']
      end
    end
  end

  describe '#contains?' do
    context 'empty storage' do
      let(:str) { 'abc, def' }

      it 'returns false' do
        subject.contains?(str).must_equal false
      end
    end

    context 'nonempty storage' do
      before do
        subject.add('uvw, xyz')
        subject.add('abc, ghi')
      end

      context 'empty string' do
        let(:str) { '' }

        it 'returns true' do
          subject.contains?(str).must_equal true
        end
      end

      context 'string present in storage' do
        let(:str) { 'abc, def' }
        before { subject.add(str) }

        it 'returns true' do
          subject.contains?(str).must_equal true
        end
      end

      context 'string absent in storage' do
        let(:str) { 'abc, def' }

        it 'returns false' do
          subject.contains?(str).must_equal false
        end
      end
    end
  end

  describe '#find' do
    it 'returns strings started with prefix'
  end
end
