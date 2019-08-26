class Linked_List
  attr_reader :tail, :head

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    if @tail
      @tail.next_node = Node.new(value) 
      @tail = @tail.next_node
    else
      @tail = Node.new(value)
    end
    @head = @tail unless @head
  end

  def prepend(value)
    new_head = Node.new(value)
    new_head.next_node = @head
    @head = new_head

    @tail = @head unless @tail
  end
  
  def size
    count = 0
    current_node = @head
    until current_node == nil
      count += 1
      current_node = current_node.next_node
    end
    count
  end

  def at(index)
    return nil if index > self.size || index < 1
    current_node = @head
    until index == 1
      current_node = current_node.next_node
      index -= 1
    end
    current_node
  end

  def pop
      popped = @tail
      if self.size <= 1
        @head = nil
        @tail = nil
      elsif self.size == 2
        @head.next_node = nil
        @tail = @head
      else
        @tail = self.at(self.size - 1)
        @tail.next_node = nil
      end
    popped ? popped.value : nil
  end

  def contains?(value)
    current_node = @head
    until current_node == nil
      return true if current_node.value == value
      current_node = current_node.next_node
    end
    false
  end

  def find(value)
    index = 1
    current_node = @head
    until current_node == nil
      return index if current_node.value == value
      current_node = current_node.next_node
      index += 1
    end
    nil
  end

  def to_s
    current_node = @head
    string = ""
    until current_node == nil
      string += "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end
    string += "nil"
  end

  def insert_at(index, value)
    if index <= 1
      self.prepend(value)
    elsif index > self.size
      self.append(value)
    else
      new_node = Node.new(value)
      preceading_node = self.at(index - 1)
      new_node.next_node = preceading_node.next_node
      preceading_node.next_node = new_node
    end
  end

  def remove_at(index)
    return nil if index > self.size || index < 1

    if index == 1 
      removed_value = @head.value
      @head = @head.next_node
    elsif index == self.size
      removed_value = self.pop.value
    else
      removed_value = self.at(index).value
      self.at(index - 1).next_node = self.at(index + 1)
    end
    removed_value ? removed_value : nil
  end
end

class Node
  attr_accessor :next_node
  attr_reader :value
  def initialize(value=nil)
    @value = value
    @next_node = nil
  end
end