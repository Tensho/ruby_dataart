class Storage

  class Node
    attr_reader :value
    attr_writer :terminal
    attr_accessor :children

    def initialize(value, children = [])
      @value = value
      @children = children
      @terminal = false
    end

    def terminal?
      @terminal
    end
  end

  attr_reader :root_node

  def initialize
    @root_node = Node.new('')
  end

  def add(str)
    words = str.split(',')

    words.each do |word|
      letters = word.split('')
      _add(root_node, letters) unless letters.empty?
    end

    self
  end

  def _add(node, values)
    value = values.shift
    child_node = node.children.detect { |child| child.value == value }
    if child_node
      _add(child_node, values)
    else
      new_node = Node.new(value)
      new_node.terminal = true if values.empty?
      node.children << new_node
      unless values.empty?
        _add(new_node, values)
      end
    end
  end

  def contains?(word)
    letters = word.split('')
    letters.empty? ? true : _contains?(root_node, letters)
  end

  def _contains?(node, values)
    value = values.shift
    child_node = node.children.detect { |child| child.value == value }
    if child_node
      values.empty? && child_node.terminal? ? true : _contains?(child_node, values)
    else
      false
    end
  end

  def find(prefix)
    letters = prefix.split('')
    raise ArgumentError, 'Prefix should be 3 letter at least' if letters.size < 3
    _find(root_node, letters)
  end

  def _find(node, values, res = [], s = '')
    if values.empty?
      node.children.each do |child_node|
        t = s.dup
        t << child_node.value
        _find(child_node, values, res, t)
        res << t if child_node.terminal?
      end
    else
      value = values.shift
      child_node = node.children.detect { |child| child.value == value }

      if child_node
        s << child_node.value
        res << s if child_node.terminal?
        _find(child_node, values, res, s)
      end

    end

    res
  end

  # TODO: via Enumerable
  def traverse(node = root_node, &block)
    node.children.each do |child_node|
      block.call(child_node) if block_given?
      traverse(child_node, &block)
    end
  end

  def to_h(node = root_node, res = {})
    key = node.value + (node.terminal? ? "(X)" : "")
    res[key] = {}
    node.children.each { |child_node| to_h(child_node, res[key]) }
    res
  end

end
