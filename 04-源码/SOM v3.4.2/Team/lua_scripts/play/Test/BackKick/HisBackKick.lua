--desc: 
gPlayTable.CreatePlay
{
firstState = "GetBall0",
["GetBall0"]={
switch =function()
if CGetBallY()<=0 then
return "GetBall1"
else return "GetBall2"
end
end
},

["GetBall1"] = {
switch = function()
if CBall2RoleDist("Kicker") < 30 then
return "PassBall1"
end
end,
Receiver=task.GotoPos("Receiver",100,130,0),
Kicker =task.GetBall("Kicker","Receiver"),
Goalie = task.Goalie()
},
["GetBall2"] = {
switch = function()
if CBall2RoleDist("Kicker") < 30 then
return "PassBall2"
end
end,
Receiver=task.GotoPos("Receiver",100,-130,0),
Kicker =task.GetBall("Kicker","Receiver"),
Goalie = task.Goalie()
},
["PassBall1"] = {
switch = function()
if CIsBallKick("Kicker") then
return "Shoot1"
end
end,
Receiver=task.GotoPos("Receiver",100,130,0),
Kicker = task.PassBall("Kicker","Receiver"),
Goalie = task.Goalie()
},
["PassBall2"] = {
switch = function()
if CIsBallKick("Kicker") then
return "Shoot2"
end
end,
Receiver=task.GotoPos("Receiver",100,-130,0),
Kicker = task.PassBall("Kicker","Receiver"),
Goalie = task.Goalie()
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
Receiver = task.ReceiverTask("shoot"),
Goalie = task.Goalie()
},
name = "HisBackKick" 
}