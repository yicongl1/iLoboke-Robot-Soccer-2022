--desc: 
gPlayTable.CreatePlay{
	firstState="GetBall",
	["GetBall"]={
		switch =function(  )
			if CBall2RoleDist("Receiver")<20 then
				return"RunningPosition"
			end
		end,
	Kicker =task.GoRecePos("Kicker"),
	Receiver =task.GetBall("Receiver","Kicker"),
	Goalie =task.Goalie()
	},
	["RunningPosition"]={
		switch =function(  )
			if COurRole2RoleDist("Kicker","Receiver")>150 then
				return"PassBall"
			end
		end,
	Kicker=task.GotoPos("Kicker",200,-150,0),
	Receiver =task.GoRecePos("Receiver"),
	Goalie =task.Goalie(),
	},
	["PassBall"]={
		switch =function(  )
			if CIsBallKick("Receiver") then
				return "KReceiveBall"
			end
		end,
		Kicker=task.Stop("Kicker"),
		Receiver =task.ReceiverTask("mypass"),
		Goalie =task.Goalie()
	},
	["KReceiveBall"]={
		switch = function(  )
			if CBall2RoleDist("Kicker")<20 then
				return "Shoot"
			end
		end,
		Kicker =task.KickerTask("myget4"),
		Receiver=task.GotoPos("Receiver",100,200,0),
		Goalie=task.Goalie()
	},
	["Shoot"]={
		switch = function(  )
			if CIsBallKick("Kicker") then
				return "finish"
			end
		end,
		Kicker =task.Shoot("Kicker"),
		Receiver=task.GotoPos("Receiver",100,200,0),
		Goalie=task.Goalie()
	},
name="passreceiveget"
}
