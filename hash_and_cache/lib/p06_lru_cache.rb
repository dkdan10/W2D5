require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache

  attr_reader :prc, :store, :map, :max

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end


  def get(key)
    val = nil
    if map.include?(key)
      val = update_node!(map.get(key))
    else
      val = calc!(key)
    end
    val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = prc.call(key)
    node = store.append(key, val)
    map.set(key, node)
    eject! if count > max 
    node.val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    node_to_add = @store.append(node.key, node.val)
    @map.set(node.key,node_to_add)
    node_to_add.val
  end

  def eject!
    node = @store.first
    @map.delete(node.key)
    node.remove
    nil
  end
end
