--desc: 
gPlayTable.CreatePlay{
	firstState="GoPos",
	["GoPos"]={
		switch = function(  )
			if( CIsGetball("Receiver"))then
				return"Passball"
			end
		end,
		Kicker =task.GotoPos("Kicker",60,80,0),
		Receiver =task.GetBall("Receiver","Kicker"),
	},
	["Passball"]={
		switch = function(  )
			if CIsGetball("Kicker") then
				return "Change"
			end
		end,
		Kicker =task.ReceiveBall("Kicker"),
		Receiver =task.PassBall("Receiver","Kicker"),
	},
	["Change"]={
		switch = function(  )
			if (COurRoleDir("Kicker")>15) then
				return "Shoot"
			end
		end,
		Kicker =task.GotoPos("Kicker",200,25,15),
	},
	["Shoot"]={
		switch = function(  )
			if CIsBallKick("Kicker") then
				return "finish"
			end
		end,
		Kicker =task.Shoot("Kicker"),
		Receiver=task.RefDef("Receiver"),
		Goalie=task.Goalie()
	},
name="MiddlePS"
}
