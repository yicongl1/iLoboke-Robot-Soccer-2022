--desc: 
gPlayTable.CreatePlay{
	firstState="GoPos",
	["GoPos"]={
		switch =function(  ) --条件过于严苛
			if (COurRole_x("Kicker")<160) and (COurRole_x("Kicker")>140) then
				if(COurRole_y("Kicker")<-40) and (COurRole_y("Kicker")>-60) then
				     return"RPassBall"
				end
			end
		end,
	Kicker=task.GotoPos("Kicker",150,-50,0),
	Receiver =task.GetBall("Receiver","Kicker"),
	Goalie =task.Goalie()
	},
	["RPassBall"]={
		switch =function(  )
			if CIsBallKick("Receiver") then 
				return"KReceBall"
			end
		end,
	Kicker=task.GoRecePos("Kicker"),
	Receiver =task.PassBall("Receiver","Kicker"),
	--Receiver =task.ReceiverTask("mypass"),--有问题
	Goalie =task.Goalie(),
	},
	["KReceBall"]={
		switch =function(  )
			if CBall2RoleDist("Kicker")<20 then
				return"Shoot"
			end
		end,
	Kicker =task.GetBall("Kicker"),
	Receiver=task.RefDef("Receiver"),
	Goalie =task.Goalie(),
	},
	["Shoot"]={
		switch = function(  )
			if CIsBallKick("Kicker") then
				return "finish"
			end
		end,
		Kicker =task.Shoot("Kicker"),
		Goalie=task.Goalie()
	},
name="test1PRM"
}