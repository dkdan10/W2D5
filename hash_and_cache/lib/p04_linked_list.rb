class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
    @next = nil
    @prev = nil
  end
end

class LinkedList
  include Enumerable
  def initialize
    head = Node.new
    tail = Node.new
    head.next = tail
    tail.prev = head
    @head = head
    @tail = tail
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = @head
    until node.next == @tail
      node = node.next
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    !get(key).nil?
  end

  def append(key, val)
    new_node = Node.new(key,val)
    new_node.next = @tail
    new_node.prev = @tail.prev
    @tail.prev.next = new_node
    @tail.prev = new_node
    new_node
  end

  def update(key, val)
    node = get_node(key)
    node.val = val unless node.nil?
  end

  def remove(key)
    node = get_node(key)
    node.remove unless node.nil?
  end

  def each
    node = @head.next
    while node != @tail
      yield(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end


   def get_node(key)
    node = @head
    until node.next == @tail
      node = node.next
      return node if node.key == key
    end
    nil
  end
end
