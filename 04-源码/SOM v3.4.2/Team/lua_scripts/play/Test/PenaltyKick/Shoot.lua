--desc: 
gPlayTable.CreatePlay{
	firstState="Change",
	["Change"]={
		switch = function(  )
			if( CBall2RoleDist("Kicker") < 10)then
				return"Shoot"
			end
		end,
		Kicker =task.GotoPos("Kicker",215,0,75),
	},
	["Shoot"]={
		switch = function(  )
			if CIsBallKick("Kicker") then
				return "finish"
			end
		end,
		Kicker =task.PenaltyKick("Kicker"),
	},
name="Shoot"
}
