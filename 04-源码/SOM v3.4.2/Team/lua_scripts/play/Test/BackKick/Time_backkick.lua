--desc: 
gPlayTable.CreatePlay{
firstState = "GetBall0",

["GetBall0"]={
	switch =function()
		if CGetBallY()<=0 then
			return "GotoPos1"
		else 
			return "GotoPos2"
		end
	end
},

["GotoPos1"] = {
	switch = function()
		if Cbuf_cnt(true,100) then
			return "GetBall1"
		elseif Cbuf_cnt(true,150) then
			return "GetBall1"
		end
end,
Receiver=task.GotoPos("Receiver",100,130,0),
Goalie = task.Goalie()
},

["GotoPos2"] = {
	switch = function()
		if Cbuf_cnt(true,100) then
			return "GetBall2"
		elseif Cbuf_cnt(true,150) then
			return "GetBall2"
		end
end,
Receiver=task.GotoPos("Receiver",100,-130,0),
Goalie = task.Goalie()
},

["GetBall1"] = {
	switch = function()
		if CBall2RoleDist("Kicker") < 30 then
			return "PassBall1"
		elseif Cbuf_cnt(true,200) then
			return "PassBall1"
		end
end,
--Receiver=task.GotoPos("Receiver",100,-130,0),
Kicker =task.GetBall("Kicker","Receiver"),
Goalie = task.Goalie()
},

["GetBall2"] = {
	switch = function()
		if CBall2RoleDist("Kicker") < 30 then
			return "PassBall2"
		elseif Cbuf_cnt(true,200) then
			return "PassBall2"
		end
	end,
--Receiver=task.GotoPos("Receiver",100,-130,0),
Kicker =task.GetBall("Kicker","Receiver"),
Goalie = task.Goalie()
},

["PassBall1"] = {
	switch = function()
		if CIsBallKick("Kicker") then
			return "Wait1"
		end
	end,
Receiver=task.GotoPos("Receiver",100,130,0),
Kicker = task.PassBall("Kicker","Receiver"),
Goalie = task.Goalie()
},

["PassBall2"] = {
	switch = function()
		if CIsBallKick("Kicker") then
			return "Wait2"
		end
	end,
Receiver=task.GotoPos("Receiver",100,-130,0),
Kicker = task.PassBall("Kicker","Receiver"),
Goalie = task.Goalie()
},

["Wait1"] = {
	switch = function()
		if Cbuf_cnt(true,150)then
			return "Shoot1"
		end
	end,
	Receiver=task.GotoPos("Receiver",40,110,0),
},

["Wait2"] = {
	switch = function()
		if Cbuf_cnt(true,150)then
			return "Shoot2"
		end
	end,
	Receiver=task.GotoPos("Receiver",40,-110,0),
},

["Shoot1"] = {
	switch = function()
		if CIsBallKick("Receiver") then
			return "finish"
		end
	end,
Kicker=task.GotoPos("Kicker",-140,0,0),
Receiver = task.ReceiverTask("shoot"),
Goalie = task.Goalie()
},
["Shoot2"] = {
	switch = function()
		if CIsBallKick("Receiver") then
			return "finish"
		end
	end,
Kicker=task.GotoPos("Kicker",-140,0,0),
--Receiver = task.ReceiverTask("shoot"),
Receiver = task.PenaltyKick("Receiver"),
Goalie = task.Goalie()
},
name = "Time_backkick" 
}