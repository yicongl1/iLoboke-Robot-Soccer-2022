goto_x = function() 
	local x
	x = 170
	return x
end

goto_y  = function()
	local y 
	if CGetBallY() > 0 then
		y = -80
	else
		y = 80
	end
	return y
end

goto_dir = function()
	return CRole2BallDir("Receiver")
end

gPlayTable.CreatePlay{
firstState = "GetBall",

["GetBall"] = {
	switch = function()
		if CBall2RoleDist("Kicker") < 30 and CIsGetBall("Kicker") then
			return "Wait"
		elseif Cbuf_cnt(true,300) then
			return "Wait"
		end
	end,
	Receiver  = task.GotoPos("Receiver",goto_x,goto_y,goto_dir),                         
	Kicker = task.GetBall("Kicker","Receiver"),
	Goalie   = task.Goalie()
},
["Wait"] = {
	switch = function()
		if Cbuf_cnt(true,100)then
			return "PassBall"
		end
	end,
	Kicker = task.GetBall("Kicker","Receiver"),
	Goalie   = task.Goalie()
},
["PassBall"] = {
	switch = function()
		if CIsBallKick("Kicker")  then
			return "Wait2"
		end
	end,
	Receiver   = task.GotoPos("Receiver",goto_x,goto_y,goto_dir),
	Kicker = task.PassBall("Kicker","Receiver"),
	Goalie   = task.Goalie()
},
["Wait2"] = {
	switch = function()
		if Cbuf_cnt(true,100)then
			return "Shoot"
		end
	end,
},
["Go"] = {
	switch = function()
		if  Cbuf_cnt(true,100) then 
			return "Shoot"
		end
	end,
	Receiver  =  task.GetBall("Receiver","Receiver"),
},

["Shoot"] = {
	switch = function()
		if CIsBallKick("Receiver") and( CBall2RoleDist("Receiver") > 60)then
			return "finh"
		elseif Cbuf_cnt(true,150) then
			return "Go"
		end
	end,
	Receiver = task.PenaltyKick("Receiver"),
	--=Receiver = task.Shoot("Receiver"),
	Kicker = task.RobotHalt("Kicker"),
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

name = "RCornerKick"
}