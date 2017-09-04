module Enumerable
  def my_each
    i = 0
    if self.class == Hash
      arr = self.to_a
      while i < self.size
        yield(arr[i][0], arr[i][1])
        i+=1
      end
    end
    
    while i < self.length
      yield(self[i])
      i+=1
    end
    self
  end
  
  def my_each_with_index
    i = 0
    
    if self.class == Hash
      arr = self.to_a
      while i < self.size
        yield(arr[i], i)
        i+=1
      end
    end
    
    while i < self.length
      yield(self[i], i)
      i+=1
    end
    self
  end
  
  def my_select
    i = 0
    klass = self.class
    object = klass.new
    
    if self.is_a? Hash
      arr = self.to_a
      while i < self.size
        if yield(arr[i][0], arr[i][1])
          object.merge!(arr[i][0] => arr[i][1])
        end
        i += 1
      end
    end
    
    while i < self.size
      if yield(self[i])
        object << self[i]
      end
      i += 1
    end
    object
  end
  
  def my_all?
    i = 0
    flag = true
    
    if self.is_a? Hash
      arr = self.to_a
      while i < self.size && flag
        flag = false if yield(arr[i][0], arr[i][1]) == false
        i += 1
      end
    end
    
    while i < self.size && flag
      flag = false if yield(self[i]) == false
      i += 1
    end
    flag
  end
  
  def my_any?
    i = 0
    flag = false
    
    if self.is_a? Hash
      arr = self.to_a
      while i < self.size && !flag
        flag = true if yield(arr[i][0], arr[i][1]) == true
        i+=1
      end
    end
    
    while i < self.size && !flag
      flag = true if yield(self[i]) == true
      i+=1
    end
    flag
  end
  
  def my_none?
    i = 0
    flag = true
    
    if self.is_a? Hash
      arr = self.to_a
      while i < self.size && flag
        flag = false if yield(arr[i][0], arr[i][1]) == true
        i+=1
      end
    end
    
    while i < self.size && flag
      flag = false if yield(self[i]) == true
      i+=1
    end
    flag
  end
  
  def my_count(n=nil, &block)
    i = 0
    res = 0
    
    if block_given?
      while i < self.size
        if block.call(self[i])
          res += 1
        end
        i +=1
      end
    else
      while i < self.size
        if self[i] == n
          res += 1
        end
        i += 1
      end
    end
    res
  end
   
  def my_map
    i = 0
    object = Array.new
    
    if self.is_a? Hash
      arr = self.to_a
      while i < self.size
        object << yield(arr[i][0], arr[i][1])
        i += 1
      end
    end
    
    while i < self.size
      object << yield(self[i])
      i += 1
    end
    object
  end
  
  def my_inject(val=0)
    i = 0
    
    if self.is_a? Hash
      arr = self.to_a
      while i < self.size
        val = yield(val, arr[i])
        i += 1
      end
    end
    
    while i < self.size
      val = yield(val, self[i])
      i += 1
    end
    val
  end
  
  def self.multiply_els(arr)
    arr.my_inject(1) {|s, v| s * v}
  end   
    
end
