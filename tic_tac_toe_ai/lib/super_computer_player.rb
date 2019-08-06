require_relative 'tic_tac_toe_node'
require "byebug"

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)

    decent_moves = []
    first = TicTacToeNode.new(game.board, mark)
    # print first
    
    first.children.each do |child|
      
      if child.winning_node?(mark)
        return child.prev_move_pos
     
      elsif !child.losing_node?(mark)  
        decent_moves << child.prev_move_pos
      end
    end
    
     return decent_moves.sample if !decent_moves.empty?
    

    raise "Error! I cannot beat you!"
  end
end



if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
