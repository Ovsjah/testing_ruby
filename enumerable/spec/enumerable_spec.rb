require 'enumerable'

describe "my implementation of the enumerable module" do
      
  describe '#my_each' do
    
    context "called by empty hash" do
      it "returns {}" do
        expect({}.my_each).to eq({})
      end
    end
    
    context "called by empty array" do
      it "returns []" do
        expect([].my_each).to eq([])
      end
    end
    
    context "called by {a: 1, b: 0, c: -3, d: 5}" do
      it "yields every key, value of the hash to the given block" do
        yielded = {}
        {a: 1, b: 0, c: -3, d: 5}.my_each { |k, v| yielded[k] = v }
        expect(yielded).to eq({a: 1, b: 0, c: -3, d: 5})
      end
    end
    
    context "called by [1, 2, 3, 4]" do
      it "yields every item of the array to the block" do
        yielded = []
        [1, 2, 3, 4].my_each { |v| yielded << v }
        expect(yielded).to eq([1, 2, 3, 4])
      end
    end
  end
  
  
  describe '#my_select' do
  
    context "{a: 1, b: 0, c: -3, d: 5}.my_select { |k, v| v > 0 }" do
      it "returns {a: 1, d: 5}" do
        expect({a: 1, b: 0, c: -3, d: 5}.my_select { |k, v| v > 0 }).to eq({a: 1, d: 5})
      end
    end
    
    context "[1, 0, -3, 5].my_select {|v| v > 0}" do
      it "returns [1, 5]" do
        expect([1, 0, -3, 5].my_select {|v| v > 0}).to eq([1, 5])
      end
    end
  end
  
  
  describe '#my_all?' do
  
    context "called by empty array" do
      it "returns true" do
        expect([].my_all?).to eq(true)
      end
    end
    
    context "{a: 1, b: -2, c: 3, d: 5}.my_all? {|k, v| v <= 0}" do
      it "returns false" do
        expect({a: 1, b: -2, c: 3, d: 5}.my_all? {|k, v| v <= 0}).to eq(false)
      end
    end
    
    context "[1, 0, 3, 5].my_all? {|n| n > -1}" do
      it "returns true" do
        expect([1, 0, 3, 5].my_all? {|n| n > -1}).to eq(true)
      end
    end
  end
  
  
  describe '#my_any?' do
  
    context "called by empty hash" do
      it "returns false" do
        expect({}.my_any?).to eq(false)
      end
    end
    
    context "{a: 1, b: 0, f: -3, d: 5}.my_any? {|k, v| k == :f}" do
      it "returns true" do
        expect({a: 1, b: 0, f: -3, d: 5}.my_any? {|k, v| k == :f}).to eq(true)
      end
    end
    
    context "[1, 2, 3, -3].my_any? {|i| i < 0}" do
      it "returns true" do
        expect([1, 2, 3, -3].my_any? {|i| i < 0}).to eq(true)
      end
    end
  end
  
  
  describe '#my_none?' do
  
    context "{a: 1, b: 0, c: -3, d: 5}.my_none? {|k, v| k == :f}" do
      it "returns true" do
        expect({a: 1, b: 0, c: -3, d: 5}.my_none? {|k, v| k == :f}).to eq(true)
      end
    end
    
    context "[1, 2, 3, -3].my_none? {|i| i > 0}" do
      it "returns false" do
        expect([1, 2, 3, -3].my_none? {|i| i > 0}).to eq(false)
      end
    end
  end
  
  
  describe '#my_count' do
    
    context "called by empty array with no parameters" do
      it "returns 0" do
        expect([].my_count).to eq(0)
      end
    end
    
    context "[1, 2, 4, 2].my_count(2)" do
      it "returns 2" do
        expect([1, 2, 4, 2].my_count(2)).to eq(2)
      end
    end
    
    context "[-4, -1, 2, 4].my_count { |v| v < 0 }" do
      it "returns 2" do
        expect([-4, -1, 2, 4].my_count {|v| v < 0}).to eq(2)
      end
    end
  end    
end
