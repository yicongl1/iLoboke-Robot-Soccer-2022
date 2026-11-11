--点球
gPlayTable.CreatePlay{
firstState = "GetBall",
["GetBall"] = {
	switch = function ()
		if CIsGetBall("Kicker") then
			return "PenaltyKick"
		end
	end,
	Kicker = task.GetBall("Kicker","Kicker"),
	Receiver = task.NormalDef("Receiver"),
	Goalie = task.Goalie()
},

["PenaltyKick"] = {
	switch = function()
		if CIsBallKick("Kicker") then
			return "finish"
		end
	end,
	--Kicker   = task.PenaltyKick("Kicker"), --官方点球函数，适用于守门员移动
	Kicker = task.KickerTask("myshoot_left"),--自写函数，适用于守门员静止
	Receiver = task.NormalDef("Receiver"),
	Goalie   = task.Goalie()
},

name = "PenaltyKick_Get"
}