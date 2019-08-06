class PolyTreeNode
    attr_reader :parent, :children, :value
    def initialize(value)
        @parent = nil 
        @children = []
        @value = value
    end

    def parent=(node)
        if node.nil? || parent
            parent.children.delete(self)
        end
            @parent = node 
            node.children << self unless node.nil? 
               
    end

    def add_child(node)
        node.parent=(self)   
    end

    def remove_child(node)
            node.parent=(nil)  
        
    end

    # def inspect
    #     @parent 
    #     @children
    #     @value
    # end

    def dfs(target)
        return self if value == target # looking at each node's value

        self.children.each do |child|
       
            result =  child.dfs(target)
            return result unless result.nil?
            
        end

        nil
    end

    def bfs(target) 
        queue = []
        queue << self 
        
        until queue.empty? 
            suspect = queue.shift 
            if suspect.value == target 
                return suspect 
            else
                suspect.children.each do |child|
                    queue << child
                end
            end
        end
        nil
    end 
end