goto_dir = function()
	return CRole2OppGoalDir("Kicker")
end

gPlayTable.CreatePlay{
firstState = "GetBall",
["GetBall"] = {
	switch = function()
		if CBall2RoleDist("Receiver") < 30 then
			return "PassBall"
		elseif Cbuf_cnt(true,200) then
			return "PassBall"
		end
	end,
Kicker=task.GotoPos("Kicker",105,-105,goto_dir),
Receiver =task.GetBall("Receiver","Kicker"),
Goalie = task.Goalie()
},
["PassBall"] = {
	switch = function()
		if CIsBallKick("Receiver") then
			return "Shoot"
		end
	end,
Kicker=task.GotoPos("Kicker",105,-105,goto_dir),
Receiver = task.PassBall("Receiver","Kicker"),
Goalie = task.Goalie()
},
["Shoot"] = {
	switch = function()
		if CIsBallKick("Kicker") then
			return "finish"
		end
	end,
Kicker = task.PenaltyKick("Kicker"),
Receiver = task.RobotHalt("Receiver"),
Goalie = task.Goalie()
},
name = "Time_cornerKick" 
}