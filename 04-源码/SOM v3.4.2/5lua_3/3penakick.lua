gPlayTable.CreatePlay
{
firstState = "PenaltyKick",
["PenaltyKick"] = {
switch = function()
if CIsBallKick("Kicker") then
return "finsh"
end
end,
Kicker = task.PenaltyKick("Kicker"),
Receiver=task.GotoPos("Receiver",50,150,0),
Goalie = task.Goalie()
},
name="3penakick"
}