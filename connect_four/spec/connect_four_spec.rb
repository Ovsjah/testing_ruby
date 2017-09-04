require 'connect_four'

describe Board do
  
  before(:all) do
    @board = Board.new
  end
  
  describe '#new' do
    it "returns a board object" do
      expect(@board).to be_an_instance_of(Board)
    end
  end
  
  describe '#grid' do
    it "returns array" do
      expect(@board.grid.class).to eq(Array)
    end
    
    it "has 7 columns" do
      expect(@board.grid.size).to eq(7)
    end
    
    it "has 6 rows" do
      expect(@board.grid[0].size).to eq(6)
    end
  end
  
  describe '#visualize' do
    it "prints human friendly board to the console" do
      expect(@board.visualize).to eq(@board.grid.transpose)
    end
  end 
end


describe Player do

  before(:all) do
    @player = Player.new("\u263a")
  end
  
  describe '#new' do
    it "returns a player object" do
      expect(@player).to be_an_instance_of(Player)
    end
  end
  
  describe '#char' do
    it "returns '☺'" do
      expect(@player.char).to eq('☺')
    end
  end
  
  describe '#drop_into' do
    it "drops smiley into the row" do
      board = Board.new
      col = 6
      
      @player.drop_into(col, board)
      
      board.visualize
      
      expect(board.grid[6][-1][0]).to eq(@player.char)
    end
  end
end


describe Game do

  before(:each) do
    @game = Game.new
    @board = @game.board.grid
    @player1 = @game.player1.char
    @player2 = @game.player2.char
  end
  
  describe '#new' do
    it "returns a game object" do
      expect(@game).to be_an_instance_of(Game)
    end
  end
  
  describe '#player1' do
    it "returns '☺'" do
      expect(@game.player1.char).to eq('☺')
    end
  end
  
  describe '#player2' do
    it "returns '☻'" do
      expect(@game.player2.char).to eq('☻')
    end
  end
  
  describe '#board' do
    it "returns a board object" do
      expect(@game.board).to be_an_instance_of(Board)
    end
  end
  
  describe '#victory?' do
    context "by default" do
      it "returns false" do
        expect(@game.victory?).to eq(false)
      end
    end
  end
  
  describe '#tie?' do
    it "returns true when there is no free space on the board" do
      @board.each_with_index do |col, idx|
        col.each_with_index do |cell, cell_idx|
          if idx.even? && cell_idx.even?
            cell[0] = @player1
          elsif idx.odd? && cell_idx.even?
            cell[0] = @player2
          elsif idx.even? && cell_idx.odd?
            cell[0] = @player2
          else
            cell[0] = @player1
          end
        end
      end
            
      @board.each_with_index do |row, idx|
        row.each_with_index do |cell, cell_idx|
          if idx < 4 && cell_idx < 3
            if @board[idx + 3][cell_idx + 3][0] == @player1
              @board[idx + 3][cell_idx + 3][0] = @player2
            else
              @board[idx + 3][cell_idx + 3][0] = @player1
            end
          elsif idx < 4 && cell_idx > 2
            if @board[idx + 2][cell_idx - 2][0] == @player1
              @board[idx + 2][cell_idx - 2][0] = @player2
            else
              @board[idx + 2][cell_idx - 2][0] = @player1
            end
          end
        end
      end
      
      @game.board.visualize
      
      expect(@game.tie?).to eq(true)
    end
  end
    
  describe '#four_in_column?' do
    it "returns true" do     
      random_column = rand(7)
      random_cell = rand(3..5)
      
      @board.each_with_index do |col, idx|
        player = [@game.player1.char, @game.player2.char].sample
        
        col.each_with_index do |cell, cell_idx|

          if idx == random_column && cell_idx == random_cell
            cell[0] = player
            @board[idx][cell_idx - 1][0] = player
            @board[idx][cell_idx - 2][0] = player
            @board[idx][cell_idx - 3][0] = player
          elsif cell_idx < random_cell
            next          
          else
            cell[0] = [@game.player1.char, @game.player2.char].sample if cell[0].nil?
          end
        end
      end
                   
      @game.board.visualize
        
      expect(@game.four_in_column?).to eq(true)
    end
  end
  
  describe '#four_in_row?' do
    it "returns true" do
      
      random_row = rand(0..3)
      random_cell = rand(6)
      
      @board.each_with_index do |row, idx|
        player = [@game.player1.char, @game.player2.char].sample
        
        row.each_with_index do |cell, cell_idx|

          if idx == random_row && cell_idx == random_cell
            cell[0] = player
            @board[idx + 1][cell_idx][0] = player
            @board[idx + 2][cell_idx][0] = player
            @board[idx + 3][cell_idx][0] = player
          elsif cell_idx < random_cell || idx < random_row
            next
          else
            cell[0] = [@game.player1.char, @game.player2.char].sample if cell[0].nil?
          end
          
        end
      end
                   
      @game.board.visualize
        
      expect(@game.four_in_row?).to eq(true)
    end
  end
    
  describe '#four_in_diagonal?' do
    it "returns true" do
      
      random_column = rand(0..3)
      random_cell = rand(5)
      
      @board.each_with_index do |col, idx|
        player = [@game.player1.char, @game.player2.char].sample
        
        col.each_with_index do |cell, cell_idx|
        
          if idx == random_column && cell_idx == random_cell && cell_idx < 3
            cell[0] = player
            @board[idx + 1][cell_idx + 1][0] = player
            @board[idx + 2][cell_idx + 2][0] = player
            @board[idx + 3][cell_idx + 3][0] = player
          elsif idx == random_column && cell_idx == random_cell && cell_idx > 2
            cell[0] = player
            @board[idx + 1][cell_idx - 1][0] = player
            @board[idx + 2][cell_idx - 2][0] = player
            @board[idx + 3][cell_idx - 3][0] = player
          elsif cell_idx < random_cell && idx != random_column + 1 && idx != random_column + 2 && idx != random_column + 3
            next 
          else
            cell[0] = [@game.player1.char, @game.player2.char].sample if cell[0].nil?
          end
          
        end
      end
      
      @game.board.visualize
      
      expect(@game.four_in_diagonal?).to eq(true)            
    end               
  end
  
  describe '#start' do
    it "starts the game" do
      expect(@game).to receive(:start)
      @game.start
    end
  end
end
