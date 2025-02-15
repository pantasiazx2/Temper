--!nonstrict

-- [버텨라! 냥키혼] //템퍼//

--[[ 
		// API //

	-- 타이머 카운팅에 함수를 바인딩하며, 경과 시간을 인수로 전달합니다.
	BindCounting(CountCallBack: () -> (number))
	
	-- 타이머를 시작합니다.
	Start()
	
	-- 타이머를 일시정지 합니다.
	Pause()
	
	-- 타이머를 재개합니다.
	Resume()
	
	-- 타이머를 멈춥니다.
	Stop()
	
--]]

local Rep = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Goodsignal = require(Rep.Goodsignal) -- 굿 시그널 경로

export type TemperOptions = {
	CountDown: boolean?,
	Duration: number?,
}

local Temper = {}
Temper.__index = Temper

function Temper.new(Option: TemperOptions)
	local self = setmetatable({}, Temper)

	if Option then
		self.CountDown = Option.CountDown or false
		self.Duration = Option.Duration or 0
		self.countDownTime = self.Duration

		self.CountDownCompleted = Goodsignal.new()
	end

	self.TimerConnection = nil
	self.running = false
	self.elapsedTime = 0

	return self
end

function Temper:BindCounting(CountCallBack: () -> (number))
	self.CountCallBack = CountCallBack
end

function Temper:Start()
	if self.TimerConnection then
		return
	end

	self.running = true

	self.TimerConnection = RunService.RenderStepped:Connect(function(deltaTime: number)
		if self.running then
			self.elapsedTime = self.elapsedTime + deltaTime  -- 델타 타임을 더해 정확한 시간 측정

			if self.CountDown then
				self.countDownTime = self.Duration - self.elapsedTime

				if self.countDownTime <= 0 then
					self.CountDownCompleted:Fire()
					self:Stop()
				end
			end

			if self.CountCallBack then
				if self.CountDown then
					self.CountCallBack(math.abs(self.countDownTime))
				else
					self.CountCallBack(self.elapsedTime)
				end
			end
		end
	end)
end

function Temper:Pause()
	self.running = false
end

function Temper:Resume()
	self.running = true
end

function Temper:Stop()
	if self.TimerConnection then
		self.TimerConnection:Disconnect()
		self.TimerConnection = nil
	end
end

return Temper
