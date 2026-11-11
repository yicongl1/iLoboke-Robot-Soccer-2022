--desc: 
BallX= function()
	return CGetBallX()
end

BallY = function()
	return CGetBallY()
end

ReceiverX= function()
	return COurRole_x("Receiver")
end
ReceiverY = function()
	return COurRole_y("Receiver")
end

Receiverdir = function()
	return CRole2BallDir("Receiver")
end
gPlayTable.CreatePlay{
firstState = "GetBall",

["GetBall"] = {
	switch = function()
		if CBall2RoleDist("Receiver") < 35 then
			return "Wait"
		elseif Cbuf_cnt(true,300) then
			return "Wait"
		end
	end,
	Kicker   = task.GetBall("Kicker","Receiver"),
	Receiver = task.GoRecePos("Receiver"),
	--Kicker   = task.GoRecePos("Kicker"),
	--Receiver = task.GetBall("Receiver","Receiver"),
	Goalie   = task.Goalie()
},
["Wait"] = {
	switch = function()
		if Cbuf_cnt(true,100)then
			return "PassBall"
		end
	end,
	Kicker = task.GetBall("Kicker","Receiver"),
	Receiver = task.GotoPos("Receiver",ReceiverX,ReceiverY,Receiverdir),
	Goalie   = task.Goalie()
},
["PassBall"] = {
	switch = function()
		if  CIsBallKick("Kicker")  then
			return "Wait2"
		end
	end,
	Kicker = task.KickerTask("mypassk"),
	--Kicker   = task.PassBall("Kicker","Receiver"),
	Receiver = task.GotoPos("Receiver",ReceiverX,ReceiverY,Receiverdir),
	--Kicker   = task.GoRecePos("Kicker"),
	--Receiver = task.PassBall("Receiver","Kicker"),
	Goalie   = task.Goalie()
},
["Wait2"] = {
	switch = function()
		if Cbuf_cnt(true,100)then
			return "Shoot"
		end
	end,
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
	Receiver = task.Shoot("Receiver"),
	--Receiver = task.PenaltyKick("Receiver"),
	--Kicker  = task.Stop("Kicker",1),
	Kicker  = task.RobotHalt("Kicker"),
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

name = "DIYRFrontKick"
}