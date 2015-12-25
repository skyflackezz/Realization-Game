class RealizationGame
	attr_accessor :currentGoal
	def m1
		[
		"You have entered a state of goal pursuit."
		]
	end
	def m2
		[
		"You suddenly realized that you want to pursue a goal.",
		"Or, did you?",
		"1) Yes. I want to pursue a goal.",
		"2) The time has not come.",
		"3) The time might have come. I just don't wanna use this app."
		]
	end
	def m3
		[
		"Your goal is to..",
		"In order to #{@currentGoal}, you can.."
		]
	end
	def append(i)
		if	not File.exists?($file)
			j = File.new($file,"a")
		end
		File.open($file,"a") do
			|j|
			j.write(i)
			j.write("\n")
		end
	end
	def retrieve(l)
		if File.exists?($file)
			File.readlines($file).map do
				|k| 
				l<<eval(k)
			end
		end
	end
end

if __FILE__ == $0
	$file = "RealizationGame.txt"
	g = RealizationGame.new()
	g.m1.each do |f| 
		print f
		gets
	end
	while true do
		h=nil
		puts g.m2
		case gets.delete "\n"
		when "2","3" then break
		when "1" then
			l=[]
			g.retrieve(l)
			
			i = []
			puts g.m3[0]
			while h==nil do
				g.currentGoal=gets.delete("\n")
					.sub(" me ", " you ").sub(" my "," your ")
				case g.currentGoal
				when "$save" then 
					h=1
					g.append(i)
					puts i
				else 
					i<<g.currentGoal
					(l.length-1).downto 0 do 
						|o|
						(l[o].length-2).downto 0 do
							|p|
							if l[o][p]==g.currentGoal
								puts "I suggest that you "+l[o][l[o].length-1] 
								puts "Would you like that?"
								q = gets.upcase.delete("\n")
								case q
								when "YES","Y"
									g.currentGoal = l[o][l[o].length-1]
									puts g.currentGoal
									i<<g.currentGoal
								else puts "Ok."
								end
							end
						end 
					end
					puts g.m3[1]
				end
			end
		end
	end
end
