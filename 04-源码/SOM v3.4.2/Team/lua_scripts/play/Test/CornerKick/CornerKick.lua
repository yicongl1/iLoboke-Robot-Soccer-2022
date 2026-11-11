--desc: 
goto_x = function() 
	local x
	x = 180
	return x
end

goto_y  = function()
	local y 
	if CGetBallY() > 0 then
		y = -80
	else
		y = 80
	end
	return y
end

goto_dir = function()
	return CRole2OppGoalDir("Kicker")
end
kickerX= function()
	return COurRole_x("Kicker")
end

kickerY = function()
	return COurRole_y("Kicker")
end
kickerdir = function()
	return CRole2BallDir("Kicker")
end
gPlayTable.CreatePlay{
firstState = "GetBall",

["GetBall"] = {
	switch = function()
		if CBall2RoleDist("Receiver") < 15 then
			return "PassBall"
		end
	end,
	Kicker   = task.GotoPos("Kicker",goto_x,goto_y,goto_dir),
	Receiver = task.GetBall("Receiver","Kicker"),
	Goalie   = task.Goalie()
},

["PassBall"] = {
	switch = function()
		if CIsBallKick("Receiver")then
			return "Wait"
		end
	end,
	Kicker   = task.GotoPos("Kicker",kickerX,kickerY,kickerdir),
	Receiver = task.ReceiverTask("mypass"),
	Goalie   = task.Goalie()
},

["Wait"] = {
	switch = function()
		if Cbuf_cnt(true,150)then
			return "Shoot"
		end
	end,
	Kicker   = task.GotoPos("Kicker",kickerX,kickerY,goto_dir),
	Receiver = task.RefDef("Receiver"),
	Goalie   = task.Goalie()
},

["Shoot"] = {
	switch = function()
		if CIsBallKick("Kicker") then
			return "finish"
		end
	end,
	Kicker = task.KickerTask("myshoot_left_fix"),
	--Kicker = task.Shoot("Kicker"),
	Receiver = task.RefDef("Receiver"),
	Goalie = task.Goalie()
},

name = "CornerKick"
}