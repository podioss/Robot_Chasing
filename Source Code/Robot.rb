class Robot
  attr_reader :name
  attr_accessor :x,:y
  def initialize(x,y,n,m)
    @x=x
    @y=y
    @name=n
    @room = m
  end
  
  def report
    return @x,@y
  end
  
  def moveRandom
    ups,downs,rights,lefts=[],[],[],[]
    if @x-2>=0 && @room[@x-2][@y-1] == "o"
      ups = Array.new(25,"up")
    end
    
    if @x<=@room[0].length-1 && @room[@x][@y-1] == "o"
      downs = Array.new(25,"down")
    end
    
    if @y-2>=0 && @room[@x-1][@y-2] == "o"
      lefts = Array.new(25,"left")
    end
    
    if @y<=@room.length-1 && @room[@x-1][@y] == "o"
      rights = Array.new(25,"right")
    end
    
    final = ups+downs+rights+lefts
    final = final.shuffle!
    
    r_index = rand(final.length-1)
    if final[r_index]=="up"
      @x+=-1
    elsif final[r_index]=="down"
      @x+=1
    elsif final[r_index]==="right"
      @y+=1
    else
      @y+=-1
    end
  
  end
end



