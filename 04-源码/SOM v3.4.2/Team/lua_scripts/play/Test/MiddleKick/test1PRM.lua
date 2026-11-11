--desc: 
gPlayTable.CreatePlay{
	firstState="GoPos",
	["GoPos"]={
		switch =function(  ) 
			if (COurRole_x("Kicker")<240) and (COurRole_x("Kicker")>220) then
				if(COurRole_y("Kicker")<-110) and (COurRole_y("Kicker")>-130) then
				     return"RPassBall"
				end
			end
		end,
	Kicker=task.GotoPos("Kicker",225,-120,0),
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
	Receiver =task.ReceiverTask("mypass1"),
	Goalie =task.Goalie(),
	},
	["KReceBall"]={
		switch =function(  )
			if CIsGetBall("Kicker") then
				return"Dir"
			end
		end,
	Kicker =task.KickerTask("myget4"),
	--Kicker =task.ReceiveBall("Kicker"),
	Receiver=task.Stop("Receiver"),
	Goalie =task.Goalie(),
	},
	["Dir"]={
		switch =function(  )
			if (COurRole_x("Kicker")<240) and (COurRole_x("Kicker")>220) then
				if(COurRole_y("Kicker")<-110) and (COurRole_y("Kicker")>-130) then
				     return"Shoot"
				 end
			end
		end,
	--Kicker =task.KickerTask("myget4"),
	Kicker=task.GotoPos("Kicker",225,-120,0),
	Receiver=task.Stop("Receiver",3),
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