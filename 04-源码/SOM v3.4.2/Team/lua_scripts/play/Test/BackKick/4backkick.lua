--desc: 
gPlayTable.CreatePlay{
firstState = "GetBall",

["GetBall"] = {
	switch = function()
		if CBall2RoleDist("Kicker") < 30 then
			return "PassBall"
		end
	end,
	Receiver = task.GotoPos("Receiver",100,120,0),
	Kicker = task.GetBall("Kicker","Receiver"),
	Goalie   = task.Goalie()
},

["PassBall"] = {
	switch = function()
		if CIsBallKick("Kicker") then
			return "Shoot"
		end
	end,
	Receiver = task.GotoPos("Receiver",100,120,0),
	-- Kicker = task.KickerTask("pass_ball"),
	Kicker = task.PassBall("Kicker","Receiver"),
	Goalie   = task.Goalie()
},

["Shoot"] = {
	switch = function()
		if CIsBallKick("Kicker") then
			return "finish"
		end
	end,
	Receiver = task.PenaltyKick("Receiver"),
	Kicker = task.GotoPos("Kicker",-200,0,0),
	Goalie = task.Goalie()
},

name = "4backkick"
}