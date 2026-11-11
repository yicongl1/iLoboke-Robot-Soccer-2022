--desc: 
local KickerRole2BallDir = function ()
    return CRole2BallDir("Kicker")
end


gPlayTable.CreatePlay{    
firstState = "GetBall",
["GetBall"] = {
switch = function()
if Cbuf_cnt((CBall2RoleDist("Receiver") < 30 and CRole2TargetDist("Kicker")< 5),120) then 
return "PassBall"
end
end,
Kicker=task.GotoPos("Kicker",130,5,KickerRole2BallDir),
Receiver = task.GetBall("Receiver","Kicker"),  --中场5号实现朝向某个角色拿球，如果第一个和第二个参数相同,则为朝向球门拿球
},


["PassBall"] = {
switch = function()
if CIsBallKick("Receiver") or CBall2RoleDist("Receiver") < 5 or Cbuf_cnt(ture,120)  then --判断球是否踢出或碰到
return "Shoot"
end
end,
--Kicker=task.GotoPos("Kicker",80,76,KickerRole2BallDir),
Kicker=task.RobotHalt("Kicker"),
Receiver = task.PassBall("Receiver","Kicker"),--实现朝向某个角色踢球，如果第一个和第二个参数相同,则为朝向球门拿球
--Receiver = task.ReceiverTask("chuanqiu2"),  --kick_back1
Goalie = task.Goalie()
},


["Shoot"] = {
switch = function()
if CIsBallKick("Kicker")  then --判断球是否踢出
return "finish"
end
end,
Receiver = task.GotoPos("Receiver",-176,-178,0),
Kicker   = task.KickerTask("shemen"),  --def
Goalie = task.Goalie()
},
name = "P_pass"
}
