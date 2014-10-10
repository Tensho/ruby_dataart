require_relative 'spec_helper'
require_relative 'storage'

describe 'Storage (implements trie data structure)' do
  subject { Storage.new }

  describe '#add' do
    context 'empty string' do
      it 'root node has not children'
    end

    context 'nonempty string' do
      it 'root node has children'
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
