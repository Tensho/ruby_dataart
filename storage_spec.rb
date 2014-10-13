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
        subject.root_node.children.map(&:value).must_be :==, ['abc']
        subject.root_node.children.flat_map(&:children).flat_map(&:value).must_be :==, ['def']
      end
    end
  end

  describe '#contains?' do
    context 'string present in storage' do
      it 'returns true'
    end

    context 'string absent in storage' do
      it 'returns false'
    end
  end

  describe '#find' do
    it 'returns strings started with prefix'
  end
end
