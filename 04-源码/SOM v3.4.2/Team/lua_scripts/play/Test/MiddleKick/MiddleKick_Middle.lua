--desc: 
--中场开球，将Kicker设定在中间进行踢球
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
--一开始都去跑位到附近的点位
["Gopos"] = {
	switch = function()
		if Cbuf_cnt(true, 150) then
			return "GetBall"
		end
	end,
	--Kicker   = task.GoRecePos("Kicker"),
	Kicker   = task.GotoPos("Kicker",-10,-100,kickerdir),
	Receiver = task.GotoPos("Receiver",-16.5,0,0),
	Goalie   = task.Goalie()
},
["GetBall"] = {
	switch = function()
		if CBall2RoleDist("Receiver") < 20 then
			return "Wait"
		elseif Cbuf_cnt(true,300) then
			return "Wait"
		end
	end,
	--Kicker   = task.GoRecePos("Kicker"),
	Kicker   = task.GotoPos("Kicker",150,-20,kickerdir),
	Receiver = task.GetBall("Receiver","Receiver"),
	Goalie   = task.Goalie()
},
["Wait"] = {
	switch = function()
		if Cbuf_cnt(true,100)then
			return "PassBall"
		end
	end,
	Kicker   = task.GotoPos("Kicker",180,-30,kickerdir),
	Receiver = task.GetBall("Receiver","Receiver"),
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
	Kicker   = task.GotoPos("Kicker",200,40,kickerdir),
	Receiver = task.NormalDef("Receiver"),
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
	Kicker = task.KickerTask("myshoot_right"),
	--Kicker   = task.PenaltyKick("Kicker"),
	Receiver = task.RefDef("Receiver"),
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
name = "MiddleKick_Middle"
}