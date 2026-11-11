--desc: 


goto_y  = function()
	local y 
	if CGetBallY() > 0 then
		y = 100
	else
		y = -100
	end
	return y
end
kickerX= function()
	return COurRole_x("Kicker")
end

kickerY = function()
	return COurRole_y("Kicker")
end
Receiverdir = function()
	return CRole2BallDir("Receiver")
end
gPlayTable.CreatePlay{
firstState = "GetBall",

["GetBall"] = {
	switch = function()
		if CBall2RoleDist("Receiver") < 35 then
			return "PassBall"
		elseif Cbuf_cnt(true,300) then
			return "PassBall"
		end
	end,
	Kicker   = task.GetBall("Kicker","Receiver"),
	Receiver  = task.GotoPos("Receiver",-50,goto_y,Receiverdir),
	--Kicker   = task.GoRecePos("Kicker"),
	--Receiver = task.GetBall("Receiver","Receiver"),
	Goalie   = task.Goalie()
},

["PassBall"] = {
	switch = function()
		if  CIsBallKick("Kicker")  then
			return "Shoot"
		elseif Cbuf_cnt(true,300) then
			return "GetBall"
		end
	end,
	Kicker   = task.PassBall("Kicker","Receiver"),
	Receiver  = task.GotoPos("Receiver",-50,goto_y,Receiverdir),
	--Kicker   = task.GoRecePos("Kicker"),
	--Receiver = task.PassBall("Receiver","Kicker"),
	Goalie   = task.Goalie()
},
["Go"]= {
	switch = function()
		if  Cbuf_cnt(true,100) then
			return "Shoot"
		end
	end,
	Receiver =  task.GetBall("Receiver","Receiver"),
	--Kicker   = task.GoRecePos("Kicker"),
	--Receiver = task.PassBall("Receiver","Kicker"),
	Goalie   = task.Goalie()
},

["Shoot"] = {
	switch = function()
		if CIsBallKick("Receiver") and( CBall2RoleDist("Receiver") > 60)then
			return "finh"
		elseif Cbuf_cnt(true,300) then
			return "Go"
		end
	end,
	--Receiver = task.Shoot("Receiver"),
	Receiver = task.PenaltyKick("Receiver"),
	Kicker  = task.GotoPos("Kicker",kickerX,kickerY,0),
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
name = "RBackKick"
}