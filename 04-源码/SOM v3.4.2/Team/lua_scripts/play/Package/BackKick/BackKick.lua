--desc: 
goto_y  = function()
	local y 
	if CGetBallY() > 0 then
		y = -100
	else
		y = 100
	end
	return y
end
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
firstState = "GetBall",
["GetBall"] = {
	switch = function()
		if CBall2RoleDist("Kicker") < 35 then
			return "Wait"
		elseif Cbuf_cnt(true,150) then
			return "Wait"
		end
	end,
	--Kicker   = task.GoRecePos("Kicker"),
	Kicker   = task.GotoPos("Kicker",50,goto_y,kickerdir),
	Receiver = task.GetBall("Receiver","Kicker"),
	Goalie   = task.Goalie()
},

["Wait"] = {
	switch = function()
		if Cbuf_cnt(true,100)then
			return "PassBall"
		end
	end,
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
	Receiver = task.ReceiverTask("mypass"),
	Goalie   = task.Goalie()
},
["Go"]= {
	switch = function()
		if  Cbuf_cnt(true,100) then
			return "Shoot"
		end
	end,
	Kicker =  task.GetBall("Kicker","Kicker"),
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
		if CIsBallKick("Kicker") and( CBall2RoleDist("Kicker") > 60)then
			return "finh"
		elseif Cbuf_cnt(true,300) then
			return "Go"
		end
	end,
	--Kicker   = task.PenaltyKick("Kicker"),
	Kicker = task.KickerTask("myshoot_right"),
	Receiver = task.GotoPos("Receiver",-90,110,0),
	Goalie = task.Goalie()
},
["finh"] = {
	switch = function()
		if Cbuf_cnt(true,300)then
			return "finish"
		end
	end,
	Receiver = task.RobotHalt("Receiver"),
	Kicker  = task.RobotHalt("Kicker"),
	Goalie = task.Goalie()
},
name = "BackKick"
}