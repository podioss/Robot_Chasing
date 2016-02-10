load "Astar.rb"
load "Robot.rb"

start_time = Time.now
f1=File.open("input.txt","r")
f_out = File.open("results.txt","w")
dim2,dim1 = f1.readline.split  
x1,y1 = f1.readline.split      
x2,y2 = f1.readline.split  
    
map = Array.new(dim1.to_i)
dim1.to_i.times do |i|
map[i] = f1.readline.split(//)[0..-2]
end
f1.close

route_exists = true
found = false
round = 1
nodes=0
robot_1 = Robot.new(x1.to_i,y1.to_i,"Bob",map)
robot_2 = Robot.new(x2.to_i,y2.to_i,"Alice",map)
f_out.puts "                  LET THE GAMES BEGIN                 "
f_out.puts "Starting positions : Alice #{robot_2.report} , Bob #{robot_1.report}"
5.times{f_out.puts}

while (route_exists && !found) do
  f_out.puts "Round No#{round}"
  robot_2.moveRandom
  f_out.puts "Alice moves to position: #{robot_2.report}"
  a = Astar.new(map,robot_1.x,robot_1.y,robot_2.x,robot_2.y,round)
  res = a.run
  nodes += a.total_nodes
  if res.is_a?(Array)
    robot_1.x,robot_1.y = res[0],res[1]
    if (res[0]==robot_2.x) && (res[1]==robot_2.y)
      f_out.puts "Bob finally reached Alice in final position #{robot_1.report}"
      found = true
     else
      f_out.puts "Bob moves to position: #{robot_1.report}"
    end
  else
    route_exists = false
  end
  round+=1
end

5.times {f_out.puts}
if found == false 
  f_out.puts "The game terminated and Bob couldn't reach Alice"
else
  f_out.puts "                GAME STATISTICS               "
  f_out.puts "Total nodes created: #{nodes}"
  end_time = Time.now
  time = (end_time - start_time) *1000
  f_out.puts "Total time elapsed: #{time}(ms)"
end
f_out.close
