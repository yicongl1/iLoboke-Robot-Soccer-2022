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
		if (CBall2RoleDist("Kicker") > 40) then
			return "GetBall"
		end
	end,
	--Kicker   = task.GoRecePos("Kicker"),
	Kicker   = task.GotoPos("Kicker",140,-90,kickerdir),
	Goalie   = task.Goalie()
},
["GetBall"] = {
	switch = function()
		if CBall2RoleDist("Receiver") < 15 then
			return "PassBall"
		end
	end,
	Kicker   = task.GotoPos("Kicker",175,-90,kickerdir),
	Receiver = task.GetBall("Receiver","Kicker"),
	Goalie   = task.Goalie()
},
	
["PassBall"] = {
	switch = function()
		if CIsGetBall("Kicker")  then
			return "Change"
		end
	end,
	Kicker   = task.GotoPos("Kicker",kickerX,kickerY,kickerdir),
	Receiver = task.ReceiverTask("mypass_gf"),
	Goalie   = task.Goalie()
},

["Change"] = {
	switch = function()
		if CBall2RoleDist("Kicker") > 30 then
			return "Shoot"
		end
	end,
	Kicker   = task.GotoPos("Kicker",200,20,kickerdir),
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
	Kicker = task.KickerTask("myshoot_right"),
	Receiver = task.GotoPos("Receiver",-90,110,0),
	Goalie = task.Goalie()
},
name = "BackKick_gf"
}