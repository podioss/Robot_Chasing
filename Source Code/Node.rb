class Node
attr_accessor :x,:y,:heuristic,:access_cost,:parent,:next,:t_cost
	def initialize(dimx,dimy,hf,ac,p)
		@x,@y,@heuristic,@access_cost,@parent = dimx,dimy,hf,ac,p
		@next=nil
		@t_cost = @heuristic + @access_cost
	end
end