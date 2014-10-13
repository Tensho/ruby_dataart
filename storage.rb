class Storage

  class Node
    attr_reader :value
    attr_accessor :children

    def initialize(value, children = [])
      @value = value
      @children = children
    end
  end

  attr_reader :root_node

  def initialize
    @root_node = Node.new('')
  end

  def add(str)
    words = str.split(', ')
    add_node(root_node, words) unless words.empty?
  end

  def add_node(node, words)
    word = words.shift
    child_node = node.children.detect { |child| child.value == word }
    unless child_node
      new_node = Node.new(word)
      node.children << new_node
      unless words.empty?
        add_node(new_node, words)
      end
    else
      add_node(child_node, words)
    end
  end

end
