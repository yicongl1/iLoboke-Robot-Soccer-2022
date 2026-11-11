--desc: 
kickerdir = function()
	return CRole2BallDir("Kicker")
end

Receiverdir = function()
	return CRole2BallDir("Receiver")
end

kickerX= function()
	return COurRole_x("Kicker")
end

kickerY = function()
	return COurRole_y("Kicker")
end

gPlayTable.CreatePlay{
firstState = "Gopos",
["Gopos"] = {
	switch = function()
		if Cbuf_cnt(true, 300) then
			return "GetBall"
		end
	end,
	--Kicker   = task.GoRecePos("Kicker"),
	Kicker   = task.GotoPos("Kicker",260,110,kickerdir),
	Goalie   = task.Goalie()
},
["GetBall"] = {
	switch = function()
		if CBall2RoleDist("Receiver") < 15 then
			return "PassBall"
		end
	end,
	Receiver = task.ReceiverTask("Face_Getball"),
	Goalie   = task.Goalie()
},
	
["PassBall"] = {
	switch = function()
		if CIsGetBall("Kicker")  then
			return "Change"
		end
	end,
	Kicker   = task.GotoPos("Kicker",kickerX,kickerY,kickerdir),
	Receiver = task.ReceiverTask("mypass"),
	Goalie   = task.Goalie()
},

["Change"] = {
	switch = function()
		if CBall2RoleDist("Kicker") > 30 then
			return "Shoot"
		end
	end,
	Kicker   = task.GotoPos("Kicker",290,150,kickerdir),
	Receiver = task.GotoPos("Receiver",-90,110,0),
	Goalie   = task.Goalie()
},
["Shoot"] = {
	switch = function()
		if CIsBallKick("Kicker") then
			return "finish"
		end
	end,
	--Kicker   = task.PenaltyKick("Kicker"),
	Kicker = task.KickerTask("myshoot_face"),
	Receiver = task.GotoPos("Receiver",-90,110,0),
	Goalie = task.Goalie()
},
name = "FrontKick_face"
}