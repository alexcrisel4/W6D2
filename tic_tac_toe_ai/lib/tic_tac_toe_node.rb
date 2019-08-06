require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)    # checks if node has lost.
    return false if board.tied?
    return true if board.over? && board.winner != evaluator
    return false if board.over? && board.winner == evaluator
    if evaluator == next_mover_mark &&  children.all? {|child| child.losing_node?(evaluator)}
      return true 
    elsif evaluator != next_mover_mark && children.any? {|child| child.losing_node?(evaluator)}
      return true
    end

    false     
  end

  def winning_node?(evaluator)
    return false if board.tied?
    return true if board.over? && board.winner == evaluator
    return false if board.over? && board.winner != evaluator
    if evaluator == next_mover_mark && children.any? {|child| child.winning_node?(evaluator)}
      return true
    elsif evaluator != next_mover_mark && children.all? { |child| child.winning_node?(evaluator)}
      return true
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_arr =[]
      (0..2).each do  |row|
        (0..2).each do |col|
          if next_mover_mark == :x
            children_mark = :o 
          else 
            children_mark = :x 
          end
          if board.empty?([row,col])
            duped = board.dup 
            duped[[row,col]] = next_mover_mark
            children_arr << TicTacToeNode.new(duped, children_mark, [row,col])
          end
        end
    end
    children_arr
  end
end
