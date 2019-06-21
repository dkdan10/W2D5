
require "byebug"
class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return @store[i] if i >= 0
    @store[(count + i)]
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each do |el|
      return true if el == val
    end
    false
  end

  def push(val)
    resize! if count >= self.capacity
    self[count] = val
    self.count += 1
  end

  def unshift(val)
    resize! if count >= self.capacity
    (0...count).each do |i|
      #debugger
      self[j + 1] = self[j]
    end
    self[0] = val
    self.count += 1
  end

  def pop
    return nil if count == 0
    ele = self[count - 1]
    self[count - 1] = nil
    self.count -= 1
    ele
  end

  def shift
    return nil if count == 0
    ele = self[0]
    self[0] = nil
    (0...count-1).each do |i|
      self[i], self[i+1] = self[i+1], self[i]
    end
    self.count -= 1
    ele
  end

  def first
    self[0]
  end

  def last
    self[count-1]
  end

  def each
    (0...count).each do |i|
      yield(@store[i])
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
    self.count == other.count
    self.each_with_index do |el, i|
      return false if el != other[i]
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!

    bigger_and_better = StaticArray.new(capacity*2)
    (0...count).each do |i|
      bigger_and_better[i] = self[i]
    end
    @store = bigger_and_better
  end
end
