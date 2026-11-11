--desc: 
kickerX= function()
	return COurRole_x("Kicker")
end

kickerY = function()
	return COurRole_y("Kicker")
end
kickerDir =function()
	return COurRoleDir("Kicker")
end

gPlayTable.CreatePlay{
firstState = "GetBall",
["GetBall"] = {
	switch = function ()
		if CIsGetBall("Kicker") and CBall2RoleDist("Kicker") < 10 then
			return "DirChange"
		end
	end,
	Kicker = task.GetBall("Kicker","Kicker"),
	Receiver = task.NormalDef("Receiver"),
	Goalie = task.Goalie()
},
["DirChange"] = {
	switch = function ()
		if CNormalStart()then
			return "PenaltyKick"
		end
	end,
	--Kicker = task.GotoPos("Kicker",kickerX,kickerY,15), 旋转至左上方然后点球命令后转回，射门位置测验固定在球门左下角
	--Kicker = task.GotoPos("Kicker",kickerX,kickerY,-45),--同上，固定在右下角，45度也可以（左下角），旋转角度很大，不知道偏离中点会不会翻车
	Kicker = task.GotoPos("Kicker",kickerX,kickerY,1), 
	Receiver = task.NormalDef("Receiver"),
	Goalie = task.Goalie()
},
["PenaltyKick"] = {
	switch = function()
		if CIsBallKick("Kicker") then
			return "finish"
		end
	end,
	Kicker   = task.PenaltyKick("Kicker"),
	Receiver = task.NormalDef("Receiver"),
	Goalie   = task.Goalie()
},

name = "PenaltyKick_Get_Fixed"
}