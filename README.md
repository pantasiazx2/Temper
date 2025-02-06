# Temper
카운트다운, 타이머 기능

-- 예제

local Rep = game:GetService("ReplicatedStorage")
local Temper = require(Rep.Temper)

local Mytimer = Temper.new({CountDown = true, Duration = 10})

Mytimer:BindCounting(function(countDownTime: number)
	script.Parent.TextLabel.Text = string.format("%.2f", tostring(countDownTime))
end)

Mytimer.CountDownCompleted:Connect(function()
	print("카운트다운 끝남")
end)

Mytimer:Start()
