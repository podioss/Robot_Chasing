load "Node.rb"
load "MinHeap.rb"

class Astar

	attr_accessor :total_nodes
	
	def initialize(m,sx,sy,gx,gy,round)
    @map=m  
		@xmap = @map.length			
		@ymap = @map[0].length									
		@spx,@spy = sx,sy
		@gpx,@gpy = gx,gy
		@visited = Array.new(@xmap){Array.new(@ymap,false)}  
		@fd = File.open("Astar_round_#{round}.txt","w+")
		@total_nodes = 0
	end

	def startNode(ax,ay,bx,by)	
		h = calculateHeuristic(ax,ay)
		Node.new(ax,ay,h,0,nil)
	end

	def calculateHeuristic(cur_x,cur_y)  
		((cur_x - @gpx).abs)+((cur_y - @gpy).abs)    #Manhattan distance (admissible heuristic)    
    #(((cur_x - @gpx).abs)**2)+(((cur_y - @gpy).abs)**2)     #square of euclidean distance (non-admissible heuristic)
	end

	def check(x1,y1,x2,y2)
		if (x1==x2 && y1==y2)
			true
		else
			false
		end
	end

	def sameNodes(anode,bnode)
		if anode == nil 
			false
		elsif (anode.x == bnode.x) && (anode.y == bnode.y)
			true
		else
			false
		end
	end

	def run
		st_node = startNode(@spx,@spy,@gpx,@gpy)
		frontier = MinHeap.new([st_node])
		counter=0
		while (!frontier.empty?) do
			cur_node = frontier.pop
			@visited[cur_node.x-1][cur_node.y-1] = true			
			
			counter+=1
			if counter>=2
			@fd.puts "Node #{counter}--->(#{cur_node.x},#{cur_node.y}) , parent: (#{cur_node.parent.x},#{cur_node.parent.y}),heuristic: #{cur_node.heuristic},access_cost: #{cur_node.access_cost}"
			else
			@fd.puts "Node #{counter}--->(#{cur_node.x},#{cur_node.y}) , parent: null,heuristic: #{cur_node.heuristic},access_cost: #{cur_node.access_cost}"
			end
			
			if (check(cur_node.x,cur_node.y,@gpx,@gpy))
				@fd.puts "-----------------------Astar found your route------------------------"
				@fd.puts "Goal --> (#{cur_node.x},#{cur_node.y})"
				while (cur_node.parent != nil) do				
					temp = cur_node
					cur_node = cur_node.parent
					@fd.puts "Node --> (#{cur_node.x},#{cur_node.y})"
					cur_node.next = temp
				end
				i=0
				while (i<2) && (cur_node.next!=nil) do   
					cur_node = cur_node.next
					i+=1
				end
				@fd.close
				return cur_node.x,cur_node.y		
			end
			deadend = true

			
			x = cur_node.x+1
			y = cur_node.y
			if (x<=@xmap) 
				if (@map[x-1][y-1] == "o") && (@visited[x-1][y-1] != true)
					new_node = Node.new(x,y,calculateHeuristic(x,y),cur_node.access_cost+1,cur_node)
					if !sameNodes(cur_node.parent,new_node)
						frontier.push(new_node)
						@visited[x-1][y-1] = true
						@total_nodes+=1
						deadend=false
					end
				end
			end
		
			
			x = cur_node.x-1
			y = cur_node.y
			if (x>=1) 
				if (@map[x-1][y-1] == "o") && (@visited[x-1][y-1] != true)
					new_node = Node.new(x,y,calculateHeuristic(x,y),cur_node.access_cost+1,cur_node)
					if !sameNodes(cur_node.parent,new_node)
						frontier.push(new_node)
						@visited[x-1][y-1] = true
						@total_nodes+=1
						deadend=false
					end
				end
			end
	
			
			x = cur_node.x
			y = cur_node.y+1
			if (y<=@ymap) 
				if (@map[x-1][y-1] == "o") && (@visited[x-1][y-1] != true)
					new_node = Node.new(x,y,calculateHeuristic(x,y),cur_node.access_cost+1,cur_node)
					if !sameNodes(cur_node.parent,new_node)
						frontier.push(new_node)
						@visited[x-1][y-1] = true
						@total_nodes+=1
						deadend=false
					end
				end
			end


			
			x = cur_node.x
			y = cur_node.y-1
			if (y>=1) 
				if (@map[x-1][y-1] == "o") && (@visited[x-1][y-1] != true)
					new_node = Node.new(x,y,calculateHeuristic(x,y),cur_node.access_cost+1,cur_node)
					if !sameNodes(cur_node.parent,new_node)
						frontier.push(new_node)
						@visited[x-1][y-1] = true
						@total_nodes+=1
						deadend=false
					end
				end
			end
	
			if (deadend==true && frontier.empty?)
				@fd.close
				return false
			end
		end 
	
	end 

end 
