require "caesar_cipher"

describe "caesar cipher with right shift" do

  describe "#caesar_chipher" do
    context "given an empty string with a whatever shift" do
      it "returns empty string" do
        expect(caesar_cipher("", rand(99))).to eql("")
      end
    end
  
    context "given the last capital letter of alphabet with shift 3" do
      it "returns 'C'" do
        expect(caesar_cipher('Z', 3)).to eql('C')
      end
    end
    
    context "given the last letter of alphabet with shift 5" do
      it "returns 'e'" do
        expect(caesar_cipher('z', 5)).to eql('e')
      end
    end
    
    context "given letter with zero shift" do
      it "returns the given letter" do
        expect(caesar_cipher('a', 0)).to eql('a')
      end
    end
    
    context "given the first capital letter of alphabet with shift 1" do
      it "returns 'B'" do
        expect(caesar_cipher('A', 1)).to eql('B')
      end
    end
    
    context "given the first letter with shift 2" do
      it "returns 'c'" do
        expect(caesar_cipher('a', 2)).to eql('c')
      end
    end
    
    context "given string with shift" do
      it "returns modified string" do
        expect(caesar_cipher("The sign of the Beast is 666!", 13)).to eql("Gur fvta bs gur Ornfg vf 666!")
      end
    end
  end
end
