--desc: 
gPlayTable.CreatePlay{
	firstState="GoPos",
	["GoPos"]={
		switch =function(  ) 
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
	--Receiver =task.PassBall("Receiver","Kicker"),
	Receiver =task.ReceiverTask("mypass"),
	Goalie =task.Goalie(),
	},
	["KReceBall"]={
		switch =function(  )
			if CIsGetBall("Kicker") then
				return"Shoot"
			end
		end,
	Kicker =task.KickerTask("myget4"),
	--Kicker =task.ReceiveBall("Kicker"),
	Receiver=task.Stop("Receiver"),
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