--desc: 
kickerdir = function()
	return CRole2BallDir("Kicker")
end
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
	Kicker   = task.KickerTask("myshoot_right"),
	Receiver = task.NormalDef("Receiver"),
	Goalie   = task.Goalie()
},

name = "PenaltyKick_Get_left"
}