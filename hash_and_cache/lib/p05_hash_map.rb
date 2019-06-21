require_relative 'p04_linked_list'
require "byebug"

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    
    memoize = bucket(key)
    if memoize.include?(key)
      memoize.update(key, val)
    else
      memoize.append(key, val)
      @count += 1 
    end
    resize! if @count >= num_buckets
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key) == nil
      @count -= 1 
    end
  end

  def each
    @store.each do |list|
      list.each do |node|
        yield(node.key, node.val)
      end
    end
  end

 # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    #debugger
    dup = @store
    @store = Array.new(@store.length * 2) { LinkedList.new}
    @count = 0
    dup.each do |list|
      list.each do |node|
        self.set(node.key, node.val)
      end
    end
  end

  public
  def bucket(key)
    i = key.hash % num_buckets
    @store[i]
  end
end
