--desc: 
goto_x = function() 
	local x
	x = 170.5
	return x
end

goto_y  = function()
	local y 
	y= 0
	return y
end
Rece_y  = function()
	local ry
	if COurRole_y("Receiver")> 0 then
		ry = 150
	else
		ry = -150
	end
	return ry
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
ReceiverX= function()
	return COurRole_x("Receiver")
end
ReceiverY = function()
	return COurRole_y("Receiver")
end
gPlayTable.CreatePlay{
firstState = "GetBall",

["GetBall"] = {
	switch = function()
		if CBall2RoleDist("Receiver") < 15 then
			return "PassBall"
		end
	end,
	Kicker   = task.GotoPos("Kicker",goto_x,goto_y,kickerdir),
	Receiver = task.ReceiverTask("Face_Getball"),
	Goalie   = task.Goalie()
},

["PassBall"] = {
	switch = function()
		if CIsGetBall("Kicker") then
			return "Change1"
		end
	end,
	Kicker   = task.GotoPos("Kicker",kickerX,kickerY,kickerdir),
	Receiver = task.ReceiverTask("mypass"),
	Goalie   = task.Goalie()
},
["Change1"] = {
	switch = function()
		if Cbuf_cnt(true,50) then
			return "Change2"
		end
	end,
	Kicker   = task.GotoPos("Kicker",kickerX,kickerY,kickerdir),
	Receiver = task.GotoPos("Receiver",150,Rece_y,0),

	Goalie   = task.Goalie()
},
["Change2"] = {
	switch = function()
		if Cbuf_cnt(true,10) then
			return "Shoot"
		end
	end,
	Kicker   = task.GotoPos("Kicker",130,0,kickerdir),
	Receiver = task.GotoPos("Receiver",150,Rece_y,0),

	Goalie   = task.Goalie()
},

["Shoot"] = {
	switch = function()
		if CIsBallKick("Kicker") then
			return "finish"
		end
	end,
	Kicker = task.KickerTask("myshoot_face"),
	--Kicker = task.Shoot("Kicker"),
	Receiver = task.RobotHalt("Receiver"),
	Goalie = task.Goalie()
},

name = "CornerKick_Middle_face"
}