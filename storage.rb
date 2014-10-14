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
    self
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

  def contains?(str)
    words = str.split(', ')
    words.empty? ? true : contains_node?(root_node, words)
  end

  def contains_node?(node, words)
    word = words.shift
    child_node = node.children.detect { |child| child.value == word }
    unless child_node
      false
    else
      if words.empty?
        true
      else
        contains_node?(child_node, words)
      end
    end
  end

  def traverse(node = root_node, res = {})
    res[node.value] = {}
    node.children.each { |child_node| traverse(child_node, res[node.value]) }
    res
  end

  def to_s
    traverse
  end

end
