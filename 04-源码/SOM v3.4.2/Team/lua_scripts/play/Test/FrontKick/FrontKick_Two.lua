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
--目前做的是二段传球，可以试试看在getball褚加对于Kicker的限定条件，让Kicker的Recive不会跑这么远
gPlayTable.CreatePlay{
firstState = "GetBall",

["GetBall"] = {
	switch = function()
		if CBall2RoleDist("Receiver") < 15 and CBall2RoleDist("Kicker") > 15  then
			return "PassBall1"
		end
	end,
	Kicker   = task.GoRecePos("Kicker"),
	Receiver = task.GetBall("Receiver","Kicker"),
},

["PassBall1"] = {
	switch = function()
		if CIsGetBall("Kicker") then
			return "Go"
		end
	end,
	Receiver = task.ReceiverTask("mypass"),
	Kicker   = task.GotoPos("Kicker",kickerX,kickerY,kickerdir),
},

["Go"] = {
	switch = function()
		if CRole2TargetDist("Kicker") < 10 then
			return "PassBall2"
		end
	end,
	Receiver = task.RefDef("Receiver",3),
	Kicker   = task.GotoPos("Kicker",200,0,kickerdir),
},
["PassBall2"] = {
	switch = function()
		if CIsGetBall("Kicker") then
			return "Change"
		end
	end,
	Receiver = task.ReceiverTask("mypass"),
	Kicker   = task.GotoPos("Kicker",kickerX,kickerY,kickerdir),
},
["Change"] = {
	switch = function()
		if CBall2RoleDist("Kicker") > 30 then
			return "Shoot"
		elseif Cbuf_cnt(true,150) then
			return "Shoot"
		end
	end,
	Kicker   = task.GotoPos("Kicker",150,20,kickerdir),
	Receiver = task.GotoPos("Receiver",0,0,0),
	--Receiver = task.Stop("Receiver",3),
},
["Shoot"] = {
	switch = function()
		if CIsBallKick("Kicker") then
			return "finish"
		end
	end,
	Kicker = task.KickerTask("myshoot_left"),
	Receiver = task.GotoPos("Receiver",0,0,0),
},

name = "FrontKick_Two"
}