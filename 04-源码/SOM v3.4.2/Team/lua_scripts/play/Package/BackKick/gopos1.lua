--desc: 
gPlayTable.CreatePlay  { 
	--数组table要有{}
	firststate = "gopos", --程序入口,起点
	switch = function()
		return "gopos"
	end,
	--定义gopos的起点含义
	["gopos"] =
		{
			Kicker = task.GotoPos("Kicker",100,-100,0) --机器人名字，x,y,角度
		},
--结尾说明脚本名字
name = "gopos1"
}