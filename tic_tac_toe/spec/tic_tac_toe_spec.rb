require 'tic_tac_toe'

describe Game do
  before(:each) do
    @game = Game.new
    @board = @game.board 
  end
  
  describe "#win" do
    context "player win when board reads X X X across top row" do
      it "returns true" do  
        @board.hash_map = [['X', 'X', 'X'], [' ', ' ', ' '], [' ', ' ', ' ']]
        expect(@game.win(X.new)).to eq(true)
      end
    end
    
    context "player win when board reads O O O across first column" do
      it "returns true" do
        @board.hash_map = [['O', ' ', ' '], ['O', ' ', ' '], ['O', ' ', ' ']]
        expect(@game.win(O.new)).to eq(true)
      end
    end
    
    context "player win when board reads X X X across diagonal from right to left" do
      it "returns true" do
        @board.hash_map = [['X', ' ', ' '], [' ', 'X', ' '], [' ', ' ', 'X']]
        expect(@game.win(X.new)).to eq(true)
      end
    end
    
    context "player win when board reads O O O across diagonal from left to right" do
      it "returns true" do
        @board.hash_map = [[' ', ' ', 'O'], [' ', 'O', ' '], ['O', ' ', ' ']]
        expect(@game.win(O.new)).to eq(true)
      end
    end
    
    context "it's a tie" do
      it "returns 'It's a tie!'" do
        @board.hash_map = [['X', 'O', 'X'], ['X', 'O', 'X'], ['O', 'X', 'O']]
        expect(@game.win(O.new)).to eq("It's a tie!")
        expect(@game.win(X.new)).to eq("It's a tie!")
      end
    end
  end
  
  
  describe "#start" do
    
    context "called by instance of class Game" do
      it "starts the game" do
        game = instance_double('Game')
        expect(game).to receive(:start)
        game.start
      end
    end
  end
  

  describe "#positioning" do
    
    context "called by instance of class Game with player parameter" do
      it "shows player's moves" do
        game = instance_double('Game')
        player = instance_double('X')
        expect(game).to receive(:positioning).with(player)
        game.positioning(player)
      end
    end
  end
end
