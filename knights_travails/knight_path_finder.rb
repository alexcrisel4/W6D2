require_relative "tree_node"
require "byebug"
class KnightPathFinder
    attr_reader :root_node, :considered_positions
    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]
        build_move_tree(@root_node)
    end

    def self.valid_moves(pos)
        y,x = pos
            positions = {
                
                "pos1" => [y+1,x+2],
                "pos2" => [y+1,x-2],
                "pos3" => [y-1,x+2],
                "pos4" => [y-1,x-2],
                "pos5" => [y+2,x+1],
                "pos6" => [y+2,x-1],
                "pos7" => [y-2,x+1],
                "pos8" => [y-2,x-1]
            }

        positions.values.select do|pos|
            (0 <= pos[0] && pos[0] <= 7) &&( 0 <= pos[1] && pos[1] <= 7)
        end
    end
    
    def new_move_positions(pos)

        current_moves = KnightPathFinder.valid_moves(pos)
        new_moves = current_moves.select { |pos| !considered_positions.include?(pos) }
        new_moves.each {|move| considered_positions << move }
        new_moves
    end

    def build_move_tree(root)
        queue = [root]
        until queue.empty? 
            suspect = queue.shift 
            new_moves = new_move_positions(suspect.value)
           
                new_moves.each do |move|
                   enqueue = PolyTreeNode.new(move)
                   enqueue.parent=(suspect)
                   queue << enqueue
                    
            end
        end
        

    end

    def find_path(end_pos)
        end_point = root_node.dfs(end_pos)
        trace_path_back(end_point)
    end

    def trace_path_back(node)
        path = []
        current = node 
        while current.parent != nil 
            path << current.value 
            current = current.parent
        end
        path << root_node.value 
        path.reverse
    end
end

a = KnightPathFinder.new([0,0])
