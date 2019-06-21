class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    dup = self.dup
    dup << 1000
    hashed = 0
    dup.each_with_index{|el,i| hashed += (el.hash * i.hash)}
    hashed.hash
  end
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.inject(0) {|acc, (k,v)| acc += ((k.hash * 1.hash) + (v.hash * 2.hash)).hash}
  end
end
