--desc: 
--中场开球，Kicker设定在右侧射门
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
		if (CBall2RoleDist("Receiver") < 30) then
			return "GetBall"
		end
	end,
	--Kicker   = task.GoRecePos("Kicker"),
	Kicker   = task.GotoPos("Kicker",175,-90,kickerdir),
	Receiver = task.GotoPos("Receiver",-16.5,0,Receiverdir),
	Goalie   = task.Goalie()
},
["GetBall"] = {
	switch = function()
		if (CBall2RoleDist("Receiver") < 15) then
			return "PassBall"
		end
	end,
	--Kicker   = task.GoRecePos("Kicker"),
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
	Receiver = task.ReceiverTask("mypass"),
	Goalie   = task.Goalie()
},

["Change"] = {
	switch = function()
		if CBall2RoleDist("Kicker") > 30 then
			return "Shoot"
		end
	end,
	Kicker   = task.GotoPos("Kicker",200,-75,kickerdir),
	Receiver = task.NormalDef("Receiver"),
	Goalie   = task.Goalie()
},
["Shoot"] = {
	switch = function()
		if CIsBallKick("Kicker") then
			return "finish"
		end
	end,
	Kicker = task.KickerTask("myshoot_left"),
	--Kicker   = task.PenaltyKick("Kicker"),
	Receiver = task.RefDef("Receiver"),
	Goalie = task.Goalie()
},

name = "MiddleKick"
}