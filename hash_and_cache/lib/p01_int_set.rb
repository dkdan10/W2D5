class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if num > (@store.length - 1) || num < 0
    @store[num] = true
  end

  def remove(num)
    raise "Out of bounds" if num > (@store.length - 1) || num < 0
    @store[num] = false
  end

  def include?(num)
    raise "Out of bounds" if num > (@store.length - 1) || num < 0
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @size = num_buckets
  end

  def insert(num)
    i = num % @size
    @store[i] << num
  end

  def remove(num)
    i = num % @size
    @store[i].delete(num)
  end

  def include?(num)
    i = num % @size
    @store[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count >= @store.length
    idx = num % @store.length
    if !self.include?(num)
      @store[idx] << num 
      @count += 1
    end
  end

  def remove(num)
    if self.include?(num)
      idx = num % @store.length
      @store[idx].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    idx = num % @store.length
    @store[idx].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    dup = @store.dup
    @store = Array.new(@store.length * 2) { Array.new}
    @count = 0
    dup.flatten.each do |ele|
      self.insert(ele)
    end
  end
end
