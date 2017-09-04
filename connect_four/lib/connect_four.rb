class Board
  attr_accessor :grid
  
  def initialize
    @grid = Array.new(7) do
      Array.new(6) { [nil] }
    end
  end
  
  def visualize
    puts %q{    
 | 0 |  | 1 |  | 2 |  | 3 |  | 4 |  | 5 |  | 6 |
 ------------------------------------------------}
 
    grid.transpose.each do |row|
      puts "#{row}"
    end  
  end
end


class Player
  attr_accessor :char
  
  def initialize(char)
    @char = char
  end
  
  def drop_into(col, board)
    column = board.grid[col.to_i]
    
    if column.none? { |cell| cell[0].nil? }
      return ">>ACHTUNG!<< | The column is full. Drop smiley into another one!"
    end
      
    column.reverse_each do |cell|
    
      if cell[0].nil?
        cell[0] = char
        break
      end
      
    end  
  end  
end


class Game
  attr_accessor :player1, :player2, :board
  
  def initialize
    @player1 = Player.new("\u263a")
    @player2 = Player.new("\u263b")
    @board = Board.new
  end
  
  def victory?
    four_in_column? || four_in_row? || four_in_diagonal?
  end
  
  def tie?
  
    res = board.grid.collect do |column|
      column.none? { |cell| cell[0].nil? }
    end

    if victory?
      false
    else
      res.all? { |item| item == true } 
    end
    
  end
  
  def four_in_column?

    board.grid.each_with_index do |col, idx|  
      col.each_with_index do |cell, c_idx|
      
        if (cell[0] == player1.char || cell[0] == player2.char) && c_idx <= 2
        
          if cell[0] == board.grid[idx][c_idx + 1][0] && cell[0] == board.grid[idx][c_idx + 2][0] && cell[0] == board.grid[idx][c_idx + 3][0]
            return true
          end
          
        end
        
      end
    end
    
    false
  end
  
  def four_in_row?
  
    transposed = board.grid.transpose
    
    transposed.each_with_index do |row, r_idx| 
      row.each_with_index do |cell, c_idx|
        if (cell[0] == player1.char || cell[0] == player2.char) && c_idx <= 3
        
          if cell[0] == transposed[r_idx][c_idx + 1][0] && cell[0] == transposed[r_idx][c_idx + 2][0] && cell[0] == transposed[r_idx][c_idx + 3][0]
            return true
          end
          
        end
                
      end
    end
    
    false  
  end
  
  def four_in_diagonal?
    
    board.grid.each_with_index do |col, idx|
      col.each_with_index do |cell, c_idx|

        if (cell[0] == player1.char || cell[0] == player2.char) && idx <= 3 && c_idx <= 2
        
          if cell[0] == board.grid[idx + 1][c_idx + 1][0] && cell[0] == board.grid[idx + 2][c_idx + 2][0] && cell[0] == board.grid[idx + 3][c_idx + 3][0]
            return true
          end
          
        elsif (cell[0] == player1.char || cell[0] == player2.char) && idx <= 3 && c_idx >= 3
          
          if cell[0] == board.grid[idx + 1][c_idx - 1][0] && cell[0] == board.grid[idx + 2][c_idx - 2][0] && cell[0] == board.grid[idx + 3][c_idx - 3][0]
            return true
          end
           
        end
        
      end
    end
    
    false
  end
  
  def start
    puts "***Hello boys and girls. Time to play Connect4***"
    puts "-------------------------------------------------"
    
    loop do
      [player1, player2].each do |player|
        puts "#{player.char} turn. Select column and drop the smiley into it"
        board.visualize
        
        print '>> '
                
        col = gets.chomp.scan(/\d/)
     
        redo if col.empty? || col[0].to_i > 6 || col.size > 1
        
        drop = player.drop_into(col[0], board)
        puts drop
        
        redo if drop
        
        if victory?
          board.visualize
          puts "#{player.char} won!"
          return victory?      
        elsif tie?
          board.visualize
          puts "GGWP!!! IT'S A TIE!!!"
          return tie?
        end
                
        puts "-" * 52
      end
    end
  end  
end
