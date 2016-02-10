class MinHeap

def initialize(arr)
	@a = arr               #a is the minHeap
 	createMinHeap
end

def createMinHeap
	((@a.length)/2).downto(0) do |i|
		heapify(i)
	end
end

def heapify(i)
	i=i+1
	l = 2*i
	r = (2*i)+1
	minTemp=0
	if (l<=@a.length) && ((@a[l-1].t_cost) < (@a[i-1].t_cost))
		minTemp = l
	else
		minTemp = i
	end
	
	if  (r<=@a.length) && (@a[r-1].t_cost < @a[minTemp-1].t_cost)
		minTemp = r
	end
	
	if minTemp!=i
		temp = @a[minTemp-1]
		@a[minTemp-1] = @a[i-1]
		@a[i-1] = temp
		heapify(minTemp-1)
	end
end

def pop
	raise "Heap is empty!" if @a.length < 1
	out = @a[0]
	@a[0] = @a[-1]
	@a=@a[0..-2]
	heapify(0)
	out
end

def push(new)
	@a = @a+[new]
	createMinHeap
end

def get
	@a
end

def empty?
	if @a.length == 0
		true
	else
		false
	end
end

end

